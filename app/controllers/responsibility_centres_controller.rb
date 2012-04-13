class ResponsibilityCentresController < ApplicationController
  # GET /responsibility_centres
  # GET /responsibility_centres.json
  def index
    @cfos = ResponsibilityCentre.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cfos }
    end
  end

  # GET /responsibility_centres/1
  # GET /responsibility_centres/1.json
  def show
    @cfo = ResponsibilityCentre.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cfo }
    end
  end

  # GET /responsibility_centres/new
  # GET /responsibility_centres/new.json
  def new
    @cfo = ResponsibilityCentre.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cfo }
    end
  end

  # GET /responsibility_centres/1/edit
  def edit
    @cfo = ResponsibilityCentre.find(params[:id])
  end

  # POST /responsibility_centres
  # POST /responsibility_centres.json
  def create
    @cfo = ResponsibilityCentre.new(params[:responsibility_centre])

    respond_to do |format|
      if @cfo.save
        format.html { redirect_to @cfo, notice: 'Responsibility centre was successfully created.' }
        format.json { render json: @cfo, status: :created, location: @cfo }
      else
        format.html { render action: "new" }
        format.json { render json: @cfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /responsibility_centres/1
  # PUT /responsibility_centres/1.json
  def update
    @cfo = ResponsibilityCentre.find(params[:id])

    respond_to do |format|
      if @cfo.update_attributes(params[:responsibility_centre])
        format.html { redirect_to @cfo, notice: 'Responsibility centre was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cfo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /responsibility_centres/1
  # DELETE /responsibility_centres/1.json
  def destroy
    @cfo = ResponsibilityCentre.find(params[:id])
    @cfo.destroy

    respond_to do |format|
      format.html { redirect_to responsibility_centres_url }
      format.json { head :no_content }
    end
  end
end
