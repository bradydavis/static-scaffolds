class <%= controller_class_name %>Controller < ApplicationController

<%  if gen_spec.nested_by -%>
  before_filter :get_<%=gen_spec.nested_by[:name]%>
<%end -%>
  before_filter :update_<%=gen_spec.singular_name%>_search

  # GET /<%= table_name %>
  # GET /<%= table_name %>.xml
  def index
    @<%=gen_spec.plural_name%> = <%=gen_spec.singular_name%>_search.paginate(nested_and_authorized_scope)
    
    # Configure Partials and Layout Text
    @header = "index_header"
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @root_navigation = "/<%=gen_spec.plural_name%>/index_navigation"
    @filter = "/<%=gen_spec.plural_name%>/facet_form"
    @title = "Index"

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @<%= table_name %> }
    end
  end
  
  def next
    @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_next(params[:id], nested_and_authorized_scope)
    redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id    
  end
  
  def prev
    @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_previous(params[:id], nested_and_authorized_scope)
    redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id    
  end

  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.xml
  def show
    @<%= file_name %> = nested_and_authorized_scope.find(params[:id])

    @header = "entry_header"
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @root_navigation = "/<%=gen_spec.plural_name%>/entry_navigation"
    @filter = "/<%=gen_spec.plural_name%>/facet_form"
    @title = "#{@<%=gen_spec.singular_name%>.short_name}"
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/new
  # GET /<%= table_name %>/new.xml
  def new
    @<%= file_name %> = nested_and_authorized_scope.new
    load_form_drop_downs

    # Configure Partials and Layout Text
    @header = "entry_header"
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @root_navigation = "/<%=gen_spec.plural_name%>/entry_navigation"
    @filter = "/<%=gen_spec.plural_name%>/facet_form"

    @title = "New <%=gen_spec.singular_title%>"

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/1/edit
  def edit
    @<%= gen_spec.singular_name %> = nested_and_authorized_scope.find(params[:id])
    @title = "Edit #{@<%=gen_spec.singular_name%>.short_name}"
    load_form_drop_downs

    # Configure Partials and Layout Text
    @header = "entry_header"
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @root_navigation = "/<%=gen_spec.plural_name%>/entry_navigation"
    @filter = "/<%=gen_spec.plural_name%>/facet_form"

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
        @title = "New <%=gen_spec.singular_title%>"
        @navigation_title = <%=gen_spec.plural_title.inspect%>
        @root_navigation = "/<%=gen_spec.plural_name%>/entry_navigation"
        @filter = "/<%=gen_spec.plural_name%>/facet_form"

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
        @navigation_title = <%=gen_spec.plural_title.inspect%>
        @root_navigation = "/<%=gen_spec.plural_name%>/entry_navigation"
        @filter = "/<%=gen_spec.plural_name%>/facet_form"
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

  def load_form_drop_downs
<% if gen_spec.belongs_to.length>0 -%>
<% for bt in gen_spec.belongs_to -%>
        @<%=bt[:name].pluralize%> = <%=bt[:model]%>.all
<% end -%>
<% end -%>    
  end

  def nested_and_authorized_scope
    # authorized not implimented yet
    nested_scope
  end
  
  def nested_scope
<%  if gen_spec.nested_by -%>
    if @<%=gen_spec.nested_by[:name]%>
      return @<%=gen_spec.nested_by[:name]%>.<%=gen_spec.plural_name%>
    else
      return <%=gen_spec.model_name%>.scoped({})
    end
<% else -%>
    return <%=gen_spec.model_name%>.scoped({})
<%end -%>    
  end

<%  if gen_spec.nested_by -%>
  def get_<%=gen_spec.nested_by[:name]%>
  	@<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params[:<%=gen_spec.nested_by[:key]%>])
  end  

<% end -%>
  def <%=gen_spec.singular_name%>_search
    @<%=gen_spec.singular_name%>_search ||= <%=gen_spec.model_name%>Search.new(session)
  end
  
  def context(obj=nil)
<%  if gen_spec.nested_by -%>
    if @<%=gen_spec.nested_by[:name]%> 
      ctx = [@<%=gen_spec.nested_by[:name]%>]
    else
      ctx = []
    end
<%else -%>
      ctx = []
<%end -%>
    if @<%=gen_spec.singular_name%>
      ctx << @<%=gen_spec.singular_name%> 
    end
    if obj
      ctx << obj
    end
    if ctx.length==1
      return ctx[0]
    else
      return ctx
    end
  end
  
  helper_method :context
  
  def update_<%=gen_spec.singular_name%>_search
    <%=gen_spec.singular_name%>_search.update_with(params)
  end
  
  helper_method :<%=gen_spec.singular_name%>_search  
  
end
