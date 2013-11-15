class OcciModelController < ApplicationController

  # GET /
  def index
    resources = Occi::Core::Resources.new

    resources.merge backend_instance.compute_get_all
    resources.merge backend_instance.network_get_all
    resources.merge backend_instance.storage_get_all

    respond_with(resources)
  end

  # GET /-/
  # GET /.well-known/org/ogf/occi/-/
  def show
    model = OcciModel.get(backend_instance, request_occi_collection)
    respond_with(model)
  end

  # POST /-/
  # POST /.well-known/org/ogf/occi/-/
  def create
    # TODO: impl
    collection = Occi::Collection.new
    respond_with(collection, status: 501)
  end

  # DELETE /-/
  # DELETE /.well-known/org/ogf/occi/-/
  def delete
    # TODO: impl
    collection = Occi::Collection.new
    respond_with(collection, status: 501)
  end

end