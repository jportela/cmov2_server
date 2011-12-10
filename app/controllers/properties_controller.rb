class PropertiesController < ApplicationController
  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @properties }
    end
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/new
  # GET /properties/new.json
  def new
    @property = Property.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @property }
    end
  end

  # GET /properties/1/edit
  def edit
    @property = Property.find(params[:id])
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(params[:property])

    respond_to do |format|
      if @property.save
        users = User.all
        users.each { |u|
          options = {
            :registration_id => u.registration_id,
            :message => "New property added to Property Market!",
            :id => @property.id,
            :name => @property.name,
            :ptype => @property.ptype,
            :collapse_key => @property.id.to_s
          }
          puts options.inspect
          response = SpeedyC2DM::API.send_notification(options)
          puts response.inspect
        }
        

        
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render json: @property, status: :created, location: @property }
      else
        format.html { render action: "new" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /properties/1
  # PUT /properties/1.json
  def update
    @property = Property.find(params[:id])

    respond_to do |format|
      if @property.update_attributes(params[:property])
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property = Property.find(params[:id])
    @property.destroy

    respond_to do |format|
      format.html { redirect_to properties_url }
      format.json { head :ok }
    end
  end
  
  def short
    @property = Property.find(params[:id])
    formatted_json = {
        :id => @property.id,
        :name => @property.name,
        :type => @property.ptype,
        :price => @property.price,
        :photo => @property.photo.url(:small)
      }
    respond_to do |format|
      format.json { render :json => formatted_json }
    end    
  end
  
  def long
    @property = Property.find(params[:id])
    formatted_json = {
        :id => @property.id,
        :name => @property.name,
        :type => @property.ptype,
        :price => @property.price,
        :photo => @property.photo.url(:normal),
        :address => @property.address,
        :city => @property.city,
        :description => @property.description,
        :created_at => @property.created_at,
        :state => @property.state 
      }
    respond_to do |format|
      format.json { render :json => formatted_json }
    end    
  end
  
  def items
    formatted_json = []
    Property.all.each { |p| 
      formatted_json << {
        :id => p.id,
        :name => p.name,
        :type => p.ptype,
        :price => p.price,
        :photo => p.photo.url(:small)
      }
    }
    respond_to do |format|
      format.json { render :json => formatted_json }
    end    
  end
  
end
