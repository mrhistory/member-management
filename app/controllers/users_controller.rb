require 'securerandom'

class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /users
  # GET /users.json
  def index
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    session[:users_sort] = params[:sort]
    session[:users_direction] = params[:direction]
    session[:users_page] = params[:page]
    session[:users_search] = params[:search]

    @users = User.search(session[:users_search]).order(sort_column + " " + sort_direction).paginate(per_page: 10, page: session[:users_page])
    set_tab(:users)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    set_tab(:users)
  end

  # GET /users/new
  def new
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    return unless redirect_if_edit_users_not_allowed!
    @user = User.new
    set_tab(:users)
  end

  # GET /users/1/edit
  def edit
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    return unless redirect_if_edit_users_not_allowed!
    set_tab(:users)
  end

  # POST /users
  # POST /users.json
  def create
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    return unless redirect_if_edit_users_not_allowed!
    @password = SecureRandom.urlsafe_base64(8)
    @user = User.new( { 
      email_address: user_params[:email_address],
      password: @password,
      password_confirmation: @password,
      view_members: params[:view_members],
      edit_members: params[:edit_members],
      view_users: params[:view_users],
      edit_users: params[:edit_users]
    })

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user, @password).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    return unless redirect_if_edit_users_not_allowed!
    respond_to do |format|
      if @user.update( { email_address: user_params[:email_address],
                        view_members: params[:view_members],
                        edit_members: params[:edit_members],
                        view_users: params[:view_users],
                        edit_users: params[:edit_users] })
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    return unless authenticate!
    return unless redirect_if_view_users_not_allowed!
    return unless redirect_if_edit_users_not_allowed!
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email_address, :password, :password_confirmation)
    end

    def sort_column
      if User.column_names.include?(session[:users_sort]) or Member.column_names.include?(session[:users_sort])
        session[:users_sort]
      else
        "email_address"
      end
    end
    
    def sort_direction
      %w[asc desc].include?(session[:users_direction]) ? session[:users_direction] : "asc"
    end
end
