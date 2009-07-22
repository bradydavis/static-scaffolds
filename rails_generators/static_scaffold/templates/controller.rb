class <%= controller_class_name %>Controller < ApplicationController
  
  before_filter :update_<%=gen_spec.singular_name%>_search
  
  # GET /<%= table_name %>
  # GET /<%= table_name %>.xml
  def index
<%  if gen_spec.nested_by -%>
    @<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params["<%=gen_spec.nested_by[:name]%>"])
    @<%=gen_spec.plural_name %> = @<%=gen_spec.nested_by[:name]%>.<%= gen_spec.plural_name %>    
<%else -%>
    @<%=gen_spec.plural_name %> = <%= gen_spec.singular_name %>_search.paginate
<%end -%>

    # Configure Partials and Layout Text
    @header = "index_header"
    @navigation = "index_navigation"
    @title = "Index"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= table_name %> }
    end
  end

  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.xml
  def show
    
    if params.has_key?("<%=gen_spec.singular_name%>_next")
      @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_next(params[:id])
      redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id
      return
    end
    if params.has_key?("<%=gen_spec.singular_name%>_previous")
      @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_previous(params[:id])
      redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id
      return
    end    
    
    
    @<%= file_name %> = <%= class_name %>.find(params[:id])

    @header = "entry_header"
    @navigation = "entry_navigation"
    @title = "#{@<%=gen_spec.singular_name%>.short_name}"
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/new
  # GET /<%= table_name %>/new.xml
  def new
    @<%= file_name %> = <%= class_name %>.new

<% if gen_spec.belongs_to.length>0 -%>
    # Form drop downs
<% for bt in gen_spec.belongs_to -%>
        @<%=bt[:name].pluralize%> = <%=bt[:model]%>.all
<% end -%>

<%end -%>

    # Configure Partials and Layout Text
    @header = "entry_header"
    @navigation = "entry_navigation"
    @title = "New <%=gen_spec.singular_title%>"


    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/1/edit
  def edit
    @<%= gen_spec.singular_name %> = <%= gen_spec.model_name %>.find(params[:id])
    @title = "Edit #{@<%=gen_spec.singular_name%>.short_name}"
<% if gen_spec.belongs_to.length>0 -%>
    # Form drop downs
<% for bt in gen_spec.belongs_to -%>
        @<%=bt[:name].pluralize%> = <%=bt[:model]%>.all
<% end -%>

<%end -%>
    # Configure Partials and Layout Text
    @header = "entry_header"
    @navigation = "entry_navigation"
    @title = "Edit #{@<%=gen_spec.singular_name%>.short_name}"
  end

  # POST /<%= table_name %>
  # POST /<%= table_name %>.xml
  def create
    @<%= file_name %> = <%= class_name %>.new(params[:<%= file_name %>])

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= class_name %> was successfully created.'

        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
      else

        # Configure Partials and Layout Text
        @header = "entry_header"
        @navigation = "entry_navigation"
        @title = "New <%=gen_spec.singular_title%>"

        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
    

    
  end

  # PUT /<%= table_name %>/1
  # PUT /<%= table_name %>/1.xml
  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])


    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:notice] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { head :ok }              
      else
        # Configure Partials and Layout Text
        @header = "entry_header"
        @navigation = "entry_navigation"
        @title = "Edit #{<%=gen_spec.singular_name%>.short_name}"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /<%= table_name %>/1
  # DELETE /<%= table_name %>/1.xml
  def destroy
    @<%= file_name %> = <%= class_name %>.find(params[:id])
    @<%= file_name %>.destroy

    respond_to do |format|
      format.html { redirect_to(<%= table_name %>_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def <%=gen_spec.singular_name%>_search
    @<%=gen_spec.singular_name%>_search ||= <%=gen_spec.model_name%>Search.new(session)
  end
  
  def update_<%=gen_spec.singular_name%>_search
    <%=gen_spec.singular_name%>_search.update_with(params)
  end
  
  helper_method :<%=gen_spec.singular_name%>_search  
  
end
