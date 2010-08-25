class TicketsController < ApplicationController
  before_filter :load_project
  before_filter :load_client
  before_filter :load_new_ticket
  before_filter :load_ticket, :only => [:show, :edit, :update, :destroy]

  protected
  def load_project
    @project = Project.find(params[:project_id], :include => [:client])
  end

  def load_client
    @client = @project.client
  end

  def load_new_ticket
    @ticket = Ticket.new(params[:ticket])
    @ticket.project = @project
  end

  def load_ticket
    @ticket = Ticket.find(params[:id])
  end

  public
  def index
    # TODO: Pagination
    @tickets = @project.tickets
  end

  def new
  end

  def create
    if @ticket.save
      flash[:notice] = "Ticket created successfully."
      redirect_to client_project_ticket_path(@client, @project, @ticket)
    else
      flash.now[:error] = "There was a problem saving the ticket."
      render :action => 'new'
    end
  end

  def show
  end

  def destroy
    if @ticket.destroy
      flash[:notice] = "Ticket destroyed successfully."
      redirect_to client_project_tickets_path(@client, @project)
    else
      flash.now[:error] = "There was a problem destroying the ticket."
      redirect_to client_project_ticket_path(@client, @project, @ticket)
    end
  end

  def edit
  end

  def update
  end
end
