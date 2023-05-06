class DiagramsController < ApplicationController
  before_action :set_diagram, only: %i[ show edit update destroy ]
  before_action :require_permission, only: [:edit, :update, :destroy]

  # GET /diagrams or /diagrams.json
  def index
    if params[:tag] 
      @diagrams = Diagram.tagged_with(params[:tag]) 
    else
      @diagrams = Diagram.all
    end
  end

  def tag_cloud
    @tags = Diagram.tag_counts_on(:tags)
  end

  # GET /diagrams/1 or /diagrams/1.json
  def show
  end

  # GET /diagrams/new
  def new
    @diagram = Diagram.new
  end

  # GET /diagrams/1/edit
  def edit
  end

  # POST /diagrams or /diagrams.json
  def create
    @diagram = Diagram.new(diagram_params)
    @diagram.user = current_user

    respond_to do |format|
      if @diagram.save
        format.html { redirect_to diagram_url(@diagram), notice: "Diagram was successfully created." }
        format.json { render :show, status: :created, location: @diagram }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagrams/1 or /diagrams/1.json
  def update
    respond_to do |format|
      if @diagram.update(diagram_params)
        format.html { redirect_to diagram_url(@diagram), notice: "Diagram was successfully updated." }
        format.json { render :show, status: :ok, location: @diagram }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagrams/1 or /diagrams/1.json
  def destroy
    @diagram.destroy
    respond_to do |format|
      format.html { redirect_to diagrams_url, notice: "Diagram was successfully destroyed." }
      format.json { head :no_content }
    end
  end

    #Use Case 2: As a user, I want to be able to tag a model with a specific tag, then search for all of the diagrams by their tag

  def tagged
    if params[:tag].present?
      @diagrams = Diagram.tagged_with(params[:tag])
    else
      @diagrams = Diagram.all
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagram
      @diagram = Diagram.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diagram_params
      params.require(:diagram).permit(:name, :description, :source_code, :user_id, :tag_list)
    end

    def require_permission
      diagram = Diagram.find(params[:id])
      if diagram.user != current_user
        redirect_to diagram_path(diagram), flash: { error: "You do not have permission to do that." }
      end
    end
end
