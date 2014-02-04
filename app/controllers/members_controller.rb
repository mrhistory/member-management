class MembersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json
  def index
    @members = Member.search(params[:search]).order(sort_column + " " + sort_direction).paginate(per_page: 10, page: params[:page])
    set_tab(:members)
  end

  # GET /members/1
  # GET /members/1.json
  def show
    set_tab(:members)
  end

  # GET /members/new
  def new
    @member = Member.new
    set_tab(:members)
  end

  # GET /members/1/edit
  def edit
    set_tab(:members)
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render action: 'show', status: :created, location: @member }
      else
        format.html { render action: 'new' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:email_address, :first_name, :last_name, :address1, :address2, :city, :state, :zipcode, :phone_number)
    end

    def sort_column
      Member.column_names.include?(params[:sort]) ? params[:sort] : "first_name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
