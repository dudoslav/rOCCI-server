class NetworkController < ApplicationController

  # GET /network/
  def index
    if request.format == "text/uri-list"
      @networks = backend_instance.network_list_ids
      @networks.map! { |c| "#{server_url}/network/#{c}" }
    else
      @networks = Occi::Collection.new
      @networks.resources = backend_instance.network_list
    end

    respond_with(@networks)
  end

  # GET /network/:id
  def show
    @network = Occi::Collection.new
    @network << backend_instance.network_get(params[:id])

    unless @network.empty?
      respond_with(@network)
    else
      respond_with(Occi::Collection.new, status: 404)
    end
  end

  # POST /network/
  def create
    network = request_occi_collection.resources.first
    network_location = backend_instance.network_create(network)

    respond_with("#{server_url}/network/#{network_location}", status: 201, flag: :link_only)
  end

  # POST /network/?action=:action
  # POST /network/:id?action=:action
  def trigger
    ai = request_occi_collection(Occi::Core::ActionInstance).action
    check_ai!(ai, request.query_string)

    if params[:id]
      result = backend_instance.network_trigger_action(params[:id], ai)
    else
      result = backend_instance.network_trigger_action_on_all(ai)
    end

    if result
      respond_with(Occi::Collection.new)
    else
      respond_with(Occi::Collection.new, status: 304)
    end
  end

  # POST /network/:id
  # PUT /network/:id
  def update
    network = request_occi_collection.resources.first
    network.id = params[:id] if network
    result = backend_instance.network_update(network)

    if result
      network = Occi::Collection.new
      network << backend_instance.network_get(params[:id])

      unless network.empty?
        respond_with(network)
      else
        respond_with(Occi::Collection.new, status: 404)
      end
    else
      respond_with(Occi::Collection.new, status: 304)
    end
  end

  # DELETE /network/
  # DELETE /network/:id
  def delete
    if params[:id]
      result = backend_instance.network_delete(params[:id])
    else
      result = backend_instance.network_delete_all
    end

    if result
      respond_with(Occi::Collection.new)
    else
      respond_with(Occi::Collection.new, status: 304)
    end
  end
end
