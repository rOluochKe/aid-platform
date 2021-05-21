module Api
    module V1
        class RequestsController < ApplicationController
            before_action :authorize_request, except: [:request_counter]

            # Get all the request [Any request with status of 1 (fulfilled) should not be displayed]
            # GET: /api/v1/requests
            def index
                requests = Request.where(status: 0)
                if requests
                    render json: requests, :include => {
                        :user => {
                            :only => [:id, :firstname, :lastname]
                        }
                    },
                    status: :ok
                else
                    render status: :unprocessable_entity
                end
            end
         
            # Make a new the request 
            # POST: /api/v1/requests
            def create
                request = Request.new({title: params[:title], reqtype: params[:reqtype], description: params[:description],
                    lat: params[:lat], lng: params[:lng], address: params[:address], status: params[:status], user_id: @current_user.id})
                if request.save
                    render json: {
                        status: 'success',
                        message: 'Request added successfully',
                        data: request
                    },
                    status: :created
                else 
                    render json: {
                        status: 'error',
                        message: 'Request not saved',
                        data: request.errors
                    },
                    status: :unprocessable_entity
                end
            end

            # Get a single request with the user that made the request [including the volunteers]
            # GET: /api/v1/requests/:id
            def show
                request = Request.includes(:user).find_by_id(params[:id])
                if request
                    render json: request, :include => {
                        :user => {
                            :only => [:id, :firstname, :lastname, :email]
                        },
                        :volunteers => {
                            :only => [:id, :user_id, :created_at],
                            :include => {
                                :user => {
                                    :only => [:id, :firstname, :lastname, :email]
                                }
                            }
                        }
                    },
                    status: :ok
                else 
                    render json: {
                        status: 'error',
                        message: 'Request not found',
                    },
                    status: :unprocessable_entity
                end
            end


            # Get request of a particular  user
            # GET: /api/v1/my-requests
            def my_request
                request = Request.where(user_id: @current_user.id)
                if request
                    render json: {
                        status: 'success',
                        message: 'Requests found',
                        data: request,
                    },
                    status: :ok
                else 
                    render json: {
                        status: 'no-content',
                        message: 'Requests not found',
                    },
                    status: :no_content
                end
            end

            # Mark request as fulfilled
            # PATCH: /api/v1/requests/:id
            def update
                request = Request.find_by_id(params[:id])
                if request
                    request.status = 1
                    if request.save
                        render json: {
                            status: 'success',
                            message: 'Request marked as fulfilled',
                        },
                        status: :ok
                    else
                        render json: {
                            status: 'error',
                            message: 'Request failed',
                            data: request.errors,
                        },
                        status: :unprocessable_entity
                    end
                else
                    render status: :unauthorized
                end
            end

            # Delete a request
            # DELETE: /api/v1/requests/:id
            def destroy
                request = Request.find_by_id(params[:id])
                if request
                    # delete the request and all associated messages and volunteering
                    request.destroy
                    render json: {
                        status: 'success',
                        message: 'Request deleted',
                    },
                    status: :ok
                else
                    render status: :unauthorized
                end
            end
            
            
            # Republish a request => find the request destroy all the volunteers and change status to 0
            # PATCH: /api/v1/republish/:request_id
            def republish
                request = Request.find_by_id(params[:request_id])
                if request
                    request.republish_status = !request.republish_status
                    if request.save
                        volunteers = Volunteer.where(request_id: params[:request_id])
                        if volunteers
                            # delete all volunteers
                            volunteers.destroy_all
                            render json: {
                                status: 'success',
                                message: 'Request republished',
                                data: request,
                            },
                            status: :ok
                        else
                            render json: {
                                status: 'error',
                                message: 'Unable to republish this request'
                            },
                            status: :unprocessable_entity
                        end
                    end
                else
                    render status: :unauthorized
                end
            end

            # count fulfilled and unfulfilled requests
            def request_counter
                unfulfilled = Request.where(status: 0)
                fulfilled = Request.where(status: 1)
                if unfulfilled && fulfilled
                    render json: {
                        status: 'success',
                        message: 'Your requests counter result',
                        data: {
                            unfulfilled: unfulfilled.length(),
                            fulfilled: fulfilled.length()
                        }
                    },
                    status: :ok
                else
                    render status: :unprocessable_entity
                end
            end

            private
            def request_params
                params.permit(:title, :reqtype, :description, :lat, :lng, :address, :status)
            end

        end
    end
end