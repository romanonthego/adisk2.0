class ChainletsController < ApplicationController
	# load_and_authorize_resource
  # uncomment lately
  
  # GET /chainlets
  # GET /chainlets.json
  def index
    @chainlets = Chainlet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @chainlets }
    end
  end

  # GET /chainlets/1
  # GET /chainlets/1.json
  def show
    @chainlet = Chainlet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @chainlet }
    end
  end

  # GET /chainlets/new
  # GET /chainlets/new.json
  def new
    @chainlet = Chainlet.new
    3.times do
      @chainlet.chainlet_links.build
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @chainlet }
    end
  end

  # GET /chainlets/1/edit
  def edit
    @chainlet = Chainlet.find(params[:id])
  end

  # POST /chainlets
  # POST /chainlets.json
  def create
    @chainlet = Chainlet.new(params[:chainlet])

    respond_to do |format|
      if @chainlet.save
        format.html { redirect_to @chainlet, notice: 'Chainlet was successfully created.' }
        format.json { render json: @chainlet, status: :created, location: @chainlet }
      else
        format.html { render action: "new" }
        format.json { render json: @chainlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /chainlets/1
  # PUT /chainlets/1.json
  def update
    @chainlet = Chainlet.find(params[:id])

    respond_to do |format|
      if @chainlet.update_attributes(params[:chainlet])
        format.html { redirect_to @chainlet, notice: 'Chainlet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @chainlet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chainlets/1
  # DELETE /chainlets/1.json
  def destroy
    @chainlet = Chainlet.find(params[:id])
    @chainlet.destroy

    respond_to do |format|
      format.html { redirect_to chainlets_url }
      format.json { head :no_content }
    end
  end
end
