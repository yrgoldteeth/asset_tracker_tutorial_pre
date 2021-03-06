class FileAttachmentsController < ApplicationController
  before_filter :load_new_file_attachment, :only => [:new, :create]
  before_filter :load_file_attachment, :only => [:show]

  protected
  def load_new_file_attachment
    @file_attachment = FileAttachment.new(params[:file_attachment])
    if params[:ticket_id]
      @file_attachment.ticket_id = params[:ticket_id]
    end
    if params[:client_id]
      @file_attachment.client_id = params[:client_id]
    end
    if params[:project_id]
      @file_attachment.project_id = params[:project_id]
    end
  end

  def load_file_attachment
    @file_attachment = FileAttachment.find(params[:id])
  end

  public
  def show
    send_file(@file_attachment.attachment_file.path, :disposition => 'attachment')
  end

  def new
  end

  def create
    if @file_attachment.save
      flash[:notice] = t(:file_attachment_created_successfully)
      redirect_to_ref_url
    else
      flash.now[:error] = t(:file_attachment_created_unsuccessfully)
      render :action => :new
    end
  end
end
