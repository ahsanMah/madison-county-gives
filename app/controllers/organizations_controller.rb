class OrganizationsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@organizations = Organization.all
	end

	def show
		@organization = Organization.find(params[:id])
		@belongs_to_current_user = (user_signed_in?) && (@organization.id == current_user.organization.id)
		@campaign_changes = @organization.campaign_changes.where("action = ?", "CREATE")
	end

	def new
		if !(current_user.organization.nil?)
			redirect_to organization_path(current_user.organization) and return
		end
		@organization = Organization.new
		short_questions = ShortQuestion.all
		short_questions.each do |question|
			response = question.short_responses.new
			@organization.short_responses << response
		end
	end

	def create
		organization = Organization.new(create_update_params)
		organization.is_approved = false
		organization.user_id = current_user.id

		create_short_responses(organization)

		if organization.save
			flash[:notice] = "Your application for #{organization.name} has been submitted. It will be approved shortly."
			redirect_to organizations_path
		else
			flash[:error] = "We were unable to create your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to new_organization_path(organization)
		end
	end

	def edit
		@organization = Organization.find(params[:id])
		existing_short_responses = @organization.short_responses.ids
		short_questions = ShortQuestion.all
		short_questions.each do |question|
			if existing_short_responses.include? question.id
				response = @organization.short_responses.find(question.id)
			else
				response = question.short_responses.new
			end
			@organization.short_responses << response
		end

	end

	def update
		organization = Organization.find(params[:id])
		organization.update(create_update_params)

		update_short_responses(organization)

		if organization.save
			flash[:notice] = "Your changes have been submitted."
			redirect_to organizations_path
		else
			flash[:warning] = "We were unable to update your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to edit_organization_path(organization)
		end
	end

private
	def create_update_params
		params.require(:organization).permit(:name, :primary_contact, :address, :email, :description, :image, :is_approved, :campaigns)
	end

	def create_short_responses(organization)
		params["organization"].each do |org_attr|
			if org_attr.match? /^short_response[\d]+$/
				question_id = org_attr.match(/^short_response([\d]+)$/).captures
				short_response = ShortResponse.new(:short_question_id => question_id, :organization_id => params[:id], :response => params["organization"][org_attr])
				short_response.save
			end
		end
	end

	def update_short_responses(organization)
		params["organization"].each do |org_attr|
			if org_attr.match? /^short_response[\d]+$/
				question_id = org_attr.match(/^short_response([\d]+)$/).captures
				short_response = ShortResponse.where('short_question_id = ? AND organization_id = ?', question_id, organization.id).distinct.first
				short_response.update(:response => params["organization"][org_attr])
				short_response.save
			end
		end
	end

end
