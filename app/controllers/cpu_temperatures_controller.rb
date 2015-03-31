class CpuTemperaturesController < ApplicationController
  # GET /cpu_temperatures
  # GET /cpu_temperatures.json
  def index
    #@cpu_temperatures = CpuTemperature.all
    @cpu_temperatures = CpuTemperature.last(200)
    @cpu_temperature_max = CpuTemperature.order('temperature DESC').first
    @cpu_temperature_min = CpuTemperature.order(:temperature).first
    
		@tempstatistic = {
			max: CpuTemperature.maximum( 'temperature' ),
			min: CpuTemperature.minimum( 'temperature' ),
			cnt: CpuTemperature.count,
			avg: CpuTemperature.average( 'temperature' )
		}
		
		# Chart output
		data_table = GoogleVisualr::DataTable.new
		# Add Column Headers
		data_table.new_column('string', 'Zeit' )
		data_table.new_column('number', 'Temperatur')
		# Add data to the chart		
		@cpu_temperatures.each do |cpu_temperature|
			data_table.add_row( [ cpu_temperature.time.to_formatted_s(:short), (cpu_temperature.temperature/10) ] )
    end
		option = { width: 800, height: 400, title: 'CPU Temperatur', 
			backgroundColor: '#FFD662',
			colors: ['#505050' ],
			fontName: 'Droid Sans' }
		@chart = GoogleVisualr::Interactive::AreaChart.new(data_table, option)

    output = %x(free -m)
    @free_memory = output.split(" ")[9].to_i
    @free_memory_total = output.split(" ")[16].to_i

    output = %x(uptime)
    @uptime = output.split(" ")[2]
    @cpuload_1 = output.split(" ")[7]
    @cpuload_5 = output.split(" ")[8]
    @cpuload_15 = output.split(" ")[9]
    @users_logged_in = output.split(" ")[3].to_i

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cpu_temperatures }
    end
  end

  # GET /cpu_temperatures/1
  # GET /cpu_temperatures/1.json
  def show
    @cpu_temperature = CpuTemperature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cpu_temperature }
    end
  end

  # GET /cpu_temperatures/new
  # GET /cpu_temperatures/new.json
  def new
    @cpu_temperature = CpuTemperature.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cpu_temperature }
    end
  end

  # GET /cpu_temperatures/1/edit
  def edit
    @cpu_temperature = CpuTemperature.find(params[:id])
  end

  # POST /cpu_temperatures
  # POST /cpu_temperatures.json
  def create
    @cpu_temperature = CpuTemperature.new(params[:cpu_temperature])

    respond_to do |format|
      if @cpu_temperature.save
        format.html { redirect_to @cpu_temperature, notice: 'Cpu temperature was successfully created.' }
        format.json { render json: @cpu_temperature, status: :created, location: @cpu_temperature }
      else
        format.html { render action: "new" }
        format.json { render json: @cpu_temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cpu_temperatures/1
  # PUT /cpu_temperatures/1.json
  def update
    @cpu_temperature = CpuTemperature.find(params[:id])

    respond_to do |format|
      if @cpu_temperature.update_attributes(params[:cpu_temperature])
        format.html { redirect_to @cpu_temperature, notice: 'Cpu temperature was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cpu_temperature.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cpu_temperatures/1
  # DELETE /cpu_temperatures/1.json
  def destroy
    # Delete all data 
    #CpuTemperature.delete_all

    # normal behaviour, delete one item:
    @cpu_temperature = CpuTemperature.find(params[:id])
    @cpu_temperature.destroy

    respond_to do |format|
      format.html { redirect_to cpu_temperatures_url }
      format.json { head :no_content }
    end
  end
end
