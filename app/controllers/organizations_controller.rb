class OrganizationsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	before_action :user_has_organization, only: [:new, :create]
	before_action :belongs_to_user, only: [:edit, :update]

	def index
		@organizations = Organization.where("is_approved = ?", true)
		if user_signed_in? && (!current_user.organization.nil?)
			@my_organization_id = current_user.organization.id
		end
	end

	def show
		@organization = Organization.find(params[:id])
		@belongs_to_current_user = (user_signed_in?) && (!current_user.organization.nil?) && (@organization.id == current_user.organization.id)
		is_admin = (user_signed_in?) && (current_user.is_admin)
		# unapproved organization is only visible to its user and the admin
		if !(@organization.is_approved?) && !(@belongs_to_current_user) && !is_admin
			 redirect_to organizations_path and return
		end
		@short_responses = get_all_short_responses
		@campaign_changes = @organization.campaign_changes.where("action = ?", "CREATE")

		@organization.campaigns.each do |campaign|
			change = campaign.campaign_change
			campaign.edit_warning = nil
			campaign.delete_warning = "Are you certain you want to submit a delete request?"
			if(!change.nil?)
				if(change.action == "UPDATE")
					campaign.delete_warning = "Are you certain you want to override your edits with a delete request?"
				else
					campaign.edit_warning = "NOTICE! Clicking the 'Submit' button on the following page will override your delete request. Do you wish to continue?"
				end
			end
		end
	end

	def new
		@organization = Organization.new
		@short_responses = ShortQuestion.all.map { |q| q.short_responses.new }
	end

	def create
		organization = Organization.new(create_update_params)
		organization.is_approved = false
		organization.user_id = current_user.id

		create_short_responses(organization)

		if organization.save
			flash[:notice] = "Your application for #{organization.name} has been submitted. It will be approved shortly."
			redirect_to organization_path(organization)
		else
			flash[:error] = "We were unable to create your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to new_organization_path(organization)
		end
	end

	def edit
		@organization = Organization.find(params[:id])
		existing_short_responses = @organization.short_responses.ids
		@short_responses = get_all_short_responses
	end

	def update
		organization = Organization.find(params[:id])
		organization.update(create_update_params)

		update_short_responses(organization)

		if organization.save
			flash[:notice] = "Your changes have been submitted."
			redirect_to organization_path(organization)
		else
			flash[:warning] = "We were unable to update your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to edit_organization_path(organization)
		end
	end

private
	def create_update_params
		params.require(:organization).permit(:name, :primary_contact, :address, :email, :description, :image, :is_approved, :campaigns)
	end

	# in case a short question is removed later by admin, its answer shouldn't be displayed; this method helps deal with this case
	def get_all_short_responses
		ShortQuestion.all.map do |q|
			existing_short_response = ShortResponse.where("organization_id = ? AND short_question_id = ?", params[:id], q.id).distinct.first
			existing_short_response.nil? ? q.short_responses.new : existing_short_response
		end
	end

	def create_short_responses(organization)
		params["organization"].each do |org_attr|
			if org_attr.match? /^short_response[\d]+$/
				question_id = org_attr.match(/^short_response([\d]+)$/).captures[0]
				short_response = ShortResponse.new(:short_question_id => question_id, :organization_id => params[:id], :response => params["organization"][org_attr])
				short_response.save
			end
		end
	end

	def update_short_responses(organization)
		params["organization"].each do |org_attr|
			if org_attr.match? /^short_response[\d]+$/
				question_id = org_attr.match(/^short_response([\d]+)$/).captures[0]
				short_response = ShortResponse.where('short_question_id = ? AND organization_id = ?', question_id, organization.id).distinct.first
				if short_response.nil?
					short_response = ShortResponse.new(:short_question_id => question_id, :organization_id => organization.id, :response => params["organization"][org_attr])
				else
					short_response.update(:response => params["organization"][org_attr])
				end
				short_response.save
			end
		end
	end

	def user_has_organization
		unless current_user.organization.nil?
			redirect_to organization_path(current_user.organization) and return
		end
	end

	def belongs_to_user
		unless Organization.find(params[:id]).user.id == current_user.id
			raise ActionController::RoutingError.new('Not Found')
		end
	end

end
