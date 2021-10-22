class TransactionTypesController < ApplicationController
  before_action :set_transaction_type, only: %i[ show edit update destroy ]

  # GET /transaction_types or /transaction_types.json
  def index
    @transaction_types = TransactionType.all
  end

  # GET /transaction_types/1 or /transaction_types/1.json
  def show
  end

  # GET /transaction_types/new
  def new
    @transaction_type = TransactionType.new
  end

  # GET /transaction_types/1/edit
  def edit
  end

  # POST /transaction_types or /transaction_types.json
  def create
    @transaction_type = TransactionType.new(transaction_type_params)

    respond_to do |format|
      if @transaction_type.save
        format.html { redirect_to @transaction_type, notice: "Transaction type was successfully created." }
        format.json { render :show, status: :created, location: @transaction_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaction_types/1 or /transaction_types/1.json
  def update
    respond_to do |format|
      if @transaction_type.update(transaction_type_params)
        format.html { redirect_to @transaction_type, notice: "Transaction type was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaction_types/1 or /transaction_types/1.json
  def destroy
    @transaction_type.destroy
    respond_to do |format|
      format.html { redirect_to transaction_types_url, notice: "Transaction type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction_type
      @transaction_type = TransactionType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_type_params
      params.require(:transaction_type).permit(:transaction_id, :category)
    end
end
