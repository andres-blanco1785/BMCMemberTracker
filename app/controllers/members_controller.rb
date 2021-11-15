# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]

  # GET /members or /members.json
  helper_method :sort_column, :sort_direction
  def index
    @members = Member.order("#{sort_column} #{sort_direction}")
    @attributes = ['UIN', 'Email', 'Phone Number', 'Join Date', 'Membership Type', 'Date', 'Officer Uin', 'Payment Method']
    # @attributeName = ['member_uin', 'email', 'phoneNumber', 'joinDate']
    @attr = Member.all
    # @sortMem = Member.order(params[:sort])
  end

  # GET /members/1 or /members/1.json
  def show; end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit; end

  # POST /members or /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_member
    @member = Member.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:member_uin, :first_name, :last_name, :email, :phone_number, :join_date)
  end

  # def sort_column
  #   params[:sort] || 'first_name'
  # end
  #
  # def sort_direction
  #   params[:direction] || 'asc'
  # end
# https://stackoverflow.com/questions/37902387/sorting-associated-column-in-table
  JOINED_TABLE_COLUMNS = %w(payments.membership_type, member.date, member.officer_uin, member.method)
  def sort_column
    if JOINED_TABLE_COLUMNS.include?(params[:sort]) || Member.column_names.include?(params[:sort])
      params[:sort]
    else
      'first_name'
    end
  end

  def sort_direction
    if %w[asc desc].include?(params[:direction]) || JOINED_TABLE_COLUMNS.include?(params[:direction])
      params[:direction]
    else
      "asc"
    end
  end
end
