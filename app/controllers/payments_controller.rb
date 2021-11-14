# frozen_string_literal: true

class PaymentsController < ApplicationController
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        @payment.officer.update(amount_owed: @payment.amount + @payment.officer.amount_owed)
        # Tell NotifyPymtMailer to send email after save
        # .deliver_now : forces deliver now to proceed, vs .deliver_later recommended but sends asynchronous
        # should get 1, but .first gets array[0] rather than array with one element... don't want [var] in email
        @var_mem_email = Member.where(member_uin: @payment.member_uin).pluck(:email).first
        @var_mem_name = Member.where(member_uin: @payment.member_uin).pluck(:first_name).first
        @var_off_name = Officer.where(officer_uin: @payment.officer_uin).pluck(:name).first
        NotifyPymtMailer.with(payment: @payment, rec_email: @var_mem_email, rec_name: @var_mem_name, off_name: @var_off_name).payment_email.deliver_now

        format.html { redirect_to @payment, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      @old_amount = @payment.amount
      @old_officer_uin = @payment.officer_uin
      @old_officer = @payment.officer
      if @payment.update(payment_params)
        if @old_officer_uin == @payment.officer_uin
          @payment.officer.update(amount_owed: @payment.officer.amount_owed + @payment.amount - @old_amount)

        else
          @payment.officer.update(amount_owed: @payment.officer.amount_owed + @payment.amount)
          @old_officer.update(amount_owed: @old_officer.amount_owed - @old_amount)
        end

        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:method, :date, :membership_type, :membership_expiration, :amount, :member_uin, :officer_uin)
  end
end
