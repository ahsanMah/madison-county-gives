class OrganizationsController < ApplicationController


	def index
		@organizations = Organization.all
	end

	def show
		@organization = Organization.find(params[:id])
	end

	def new
		@organization = Organization.new
		short_questions = ShortQuestion.all
		short_questions.each do |question|
			response = question.short_responses.new
			@organization.short_responses << response
		end
		short_questions.save!
	end

	def create
		organization = Organization.new(create_update_params)
		organization.is_approved = false
		organization.user_id = current_user.id
		if organization.save && organization.short_responses.save
			flash[:notice] = "\"#{organization.name}\" submitted. Julie will contact you shortly!"
			redirect_to organizations_path
		else
			flash[:error] = "We were unable to create your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to new_organization_path(organization)
		end
	end

	def edit
		@organization = Organization.find(params[:id])
	end

	def update
		organization = Organization.find(params[:id])
		organization.update(create_update_params)
		if organization.save && organization.short_responses.save
			flash[:notice] = "Submitted changes for approval. Someone will review them shortly!"
			redirect_to organizations_path
		else
			flash[:warning] = "We were unable to update your organization profile. " + organization.errors.full_messages.join(". ")
			redirect_to edit_organization_path(organization)
		end
	end

private
	def create_update_params
		params.require(:organization).permit(:name, :primary_contact, :address, :email, :short_responses, :description, :image, :is_approved, :campaigns)
  	end

end
