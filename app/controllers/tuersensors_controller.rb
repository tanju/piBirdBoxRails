class TuersensorsController < ApplicationController
  # GET /tuersensors
  # GET /tuersensors.json
  def index
		# SELECT food_id, COUNT(*) FROM food_logs GROUP BY date(log_date, 'unixepoch');
		# http://stackoverflow.com/questions/10691560/group-by-range-of-timestamp-values

    @dailyVisits = Tuersensor.select("date(created_at) as day, count(movetype) as cnt").group("date(created_at)")
    @tuersensors = Tuersensor.all

    # Chart output
    data_table = GoogleVisualr::DataTable.new
    # Add Column Headers
    data_table.new_column('string', 'Tag' )
    data_table.new_column('number', 'Anzahl')
    # Add data to the chart   
    @dailyVisits.each do |day|
      data_table.add_row( [ day.day, day.cnt ] )
    end
    option = { width: 800, height: 400, title: 'Besuche pro Tag', 
      backgroundColor: '#FFD662',
      colors: ['#505050' ],
      fontName: 'Droid Sans' }
    @chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, option)


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tuersensors }
    end
  end

  # GET /tuersensors/1
  # GET /tuersensors/1.json
  def show
    @tuersensor = Tuersensor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tuersensor }
    end
  end

  # GET /tuersensors/new
  # GET /tuersensors/new.json
  def new
    @tuersensor = Tuersensor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tuersensor }
    end
  end

  # GET /tuersensors/1/edit
  def edit
    @tuersensor = Tuersensor.find(params[:id])
  end

  # POST /tuersensors
  # POST /tuersensors.json
  def create
    @tuersensor = Tuersensor.new(params[:tuersensor])

    respond_to do |format|
      if @tuersensor.save
        format.html { redirect_to @tuersensor, notice: 'Tuersensor was successfully created.' }
        format.json { render json: @tuersensor, status: :created, location: @tuersensor }
      else
        format.html { render action: "new" }
        format.json { render json: @tuersensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tuersensors/1
  # PUT /tuersensors/1.json
  def update
    @tuersensor = Tuersensor.find(params[:id])

    respond_to do |format|
      if @tuersensor.update_attributes(params[:tuersensor])
        format.html { redirect_to @tuersensor, notice: 'Tuersensor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @tuersensor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tuersensors/1
  # DELETE /tuersensors/1.json
  def destroy
    @tuersensor = Tuersensor.find(params[:id])
    @tuersensor.destroy

    respond_to do |format|
      format.html { redirect_to tuersensors_url }
      format.json { head :no_content }
    end
  end
end
