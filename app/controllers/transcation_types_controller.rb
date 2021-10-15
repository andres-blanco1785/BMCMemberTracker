class TranscationTypesController < ApplicationController
  before_action :set_transcation_type, only: %i[ show edit update destroy ]

  # GET /transcation_types or /transcation_types.json
  def index
    @transcation_types = TranscationType.all
  end

  # GET /transcation_types/1 or /transcation_types/1.json
  def show
  end

  # GET /transcation_types/new
  def new
    @transcation_type = TranscationType.new
  end

  # GET /transcation_types/1/edit
  def edit
  end

  # POST /transcation_types or /transcation_types.json
  def create
    @transcation_type = TranscationType.new(transcation_type_params)

    respond_to do |format|
      if @transcation_type.save
        format.html { redirect_to @transcation_type, notice: "Transcation type was successfully created." }
        format.json { render :show, status: :created, location: @transcation_type }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transcation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transcation_types/1 or /transcation_types/1.json
  def update
    respond_to do |format|
      if @transcation_type.update(transcation_type_params)
        format.html { redirect_to @transcation_type, notice: "Transcation type was successfully updated." }
        format.json { render :show, status: :ok, location: @transcation_type }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transcation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transcation_types/1 or /transcation_types/1.json
  def destroy
    @transcation_type.destroy
    respond_to do |format|
      format.html { redirect_to transcation_types_url, notice: "Transcation type was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transcation_type
      @transcation_type = TranscationType.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transcation_type_params
      params.require(:transcation_type).permit(:intger, :transcation_id, :string)
    end
end
