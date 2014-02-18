class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /login
  def login
    set_tab(:login)
  end

  # POST /authenticate
  def authenticate
    session[:user] = User.where(email_address: params[:email_address]).first.try(:authenticate, params[:password])
    if !session[:user].nil?
      cookies.signed[:user] = session[:user] unless params[:remember_me] != '1'
      redirect_to members_path
    else
      @error = 'Incorrect email address or password.'
      render action: 'login'
    end
    set_tab(:login)
  end

  # GET /logout
  def logout
    cookies.delete :user
    reset_session
    redirect_to login_path
  end

  # GET /users
  # GET /users.json
  def index
    authenticate!
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
    authenticate!
    set_tab(:users)
  end

  # GET /users/new
  def new
    authenticate!
    @user = User.new
    set_tab(:users)
  end

  # GET /users/1/edit
  def edit
    authenticate!
    set_tab(:users)
  end

  # POST /users
  # POST /users.json
  def create
    authenticate!
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
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
    authenticate!
    respond_to do |format|
      if @user.update(user_params)
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
    authenticate!
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
      User.column_names.include?(session[:users_sort]) ? session[:users_sort] : "email_address"
    end
    
    def sort_direction
      %w[asc desc].include?(session[:users_direction]) ? session[:users_direction] : "asc"
    end
end
