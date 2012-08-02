require 'pry'
require 'pry-nav'

module AppossFile
  class FileEntriesController < ApplicationController
    respond_to :js

    def index
      @collection = FileEntry.where(app_id: params[:app_id])
    end

    def new
      @resource = FileEntry.new app_id: params[:app_id]
    end

    def create
      @resource = FileEntry.new params[:file_entry]
      if @resource.save
        redirect_to file_entries_path(app_id: @resource.app_id)
      else
        Rails.logger.error "FileEntry create fail: #{@resource.errors.messages}"
      end
    end

    def destroy
      @resource = FileEntry.find params[:id]
      @resource.destroy
      @collection = FileEntry.where app_id: @resource.app_id
    end

  end
end
