class LogtextsController < ApplicationController
  # GET /logtexts
  # GET /logtexts.json
  def index
    @logtexts = Logtext.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logtexts }
    end
  end

  # GET /logtexts/1
  # GET /logtexts/1.json
  def show
    @logtext = Logtext.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @logtext }
    end
  end

  # GET /logtexts/new
  # GET /logtexts/new.json
  def new
    @logtext = Logtext.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @logtext }
    end
  end

  # GET /logtexts/1/edit
  def edit
    @logtext = Logtext.find(params[:id])
  end

  # POST /logtexts
  # POST /logtexts.json
  def create
    @logtext = Logtext.new(params[:logtext])

    respond_to do |format|
      if @logtext.save
        format.html { redirect_to @logtext, notice: 'Logtext was successfully created.' }
        format.json { render json: @logtext, status: :created, location: @logtext }
      else
        format.html { render action: "new" }
        format.json { render json: @logtext.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logtexts/1
  # PUT /logtexts/1.json
  def update
    @logtext = Logtext.find(params[:id])

    respond_to do |format|
      if @logtext.update_attributes(params[:logtext])
        format.html { redirect_to @logtext, notice: 'Logtext was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logtext.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logtexts/1
  # DELETE /logtexts/1.json
  def destroy
    @logtext = Logtext.find(params[:id])
    @logtext.destroy

    respond_to do |format|
      format.html { redirect_to logtexts_url }
      format.json { head :no_content }
    end
  end
end
