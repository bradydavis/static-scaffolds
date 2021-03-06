class <%= controller_class_name %>Controller < ApplicationController

  # GET /<%= table_name %>
  # GET /<%= table_name %>.xml
  def index
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>
    update_<%=gen_spec.singular_name%>_search
    @<%=gen_spec.plural_name%> = <%=gen_spec.singular_name%>_search.paginate(nested_and_authorized_scope)
    
    # Configure Partials and Layout Text
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @title = "<%=gen_spec.plural_title%>"

    respond_to do |format|
      format.html {
        @model_selector = <%=index_model_selector.inspect%>
        @side_panel_partials = ["/<%=gen_spec.plural_name%>/facet_form"]
<% for f in gen_spec.search_facets.select {|sf| sf[:type]=="checkbox_facet"} -%>
        <%=gen_spec.singular_name%>_search.<%=f[:name]%>.load_selection_options(nested_and_authorized_scope)
<% end -%>
      } # index.html.erb
      format.js   # index.js.erb
      format.xml  { render :xml => @<%= table_name %> }
    end
  end
  
  
  def map
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>
    update_<%=gen_spec.singular_name%>_search
    @<%=gen_spec.plural_name%> = <%=gen_spec.singular_name%>_search.paginate(nested_and_authorized_scope)

    # Configure Partials and Layout Text
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @title = "<%=gen_spec.plural_title%>"

    respond_to do |format|
      format.html {
        @google_api_key = GOOGLE_API_KEY
        @model_selector = <%=index_model_selector.inspect%>
        @side_panel_partials = ["/<%=gen_spec.plural_name%>/facet_form"]
<% for f in gen_spec.search_facets.select {|sf| sf[:type]=="checkbox_facet"} -%>
        <%=gen_spec.singular_name%>_search.<%=f[:name]%>.load_selection_options(nested_and_authorized_scope)
<% end -%>
      } # map.html.erb
      format.js   # map.js.erb
    end
  end  
  
  def next
<%  if gen_spec.nested_by -%>
    load_parent_resources
    @<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params[:<%=gen_spec.nested_by[:key]%>])
<% end -%>
    update_<%=gen_spec.singular_name%>_search    
    @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_next(params[:id], authorized_scope)
    redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id    
  end
  
  def prev
<%  if gen_spec.nested_by -%>
    load_parent_resources
    @<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params[:<%=gen_spec.nested_by[:key]%>])
<% end -%>
    update_<%=gen_spec.singular_name%>_search    
    @<%=gen_spec.singular_name%> = <%=gen_spec.singular_name%>_search.get_previous(params[:id], authorized_scope)
    redirect_to :action=>:show, :id=>@<%=gen_spec.singular_name%>.id    
  end

  # GET /<%= table_name %>/1
  # GET /<%= table_name %>/1.xml
  def show
    @<%= file_name %> = authorized_scope.find(params[:id])
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>

    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @model_selector = <%=entry_model_selector.inspect%>
    @title = "#{@<%=gen_spec.singular_name%>.short_name}"
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/new
  # GET /<%= table_name %>/new.xml
  def new
<%  if gen_spec.nested_by -%>
    @<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params[:<%=gen_spec.nested_by[:key]%>])
<% end -%>
    @<%= file_name %> = authorized_scope.new
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>
    
    load_form_drop_downs

    # Configure Partials and Layout Text
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @title = "New <%=gen_spec.singular_title%>"
    @model_selector = <%=index_model_selector.inspect%>

    respond_to do |format|

      format.html {
        @side_panel_partials = ["/<%=gen_spec.plural_name%>/facet_form"]
<% for f in gen_spec.search_facets.select {|sf| sf[:type]=="checkbox_facet"} -%>
        <%=gen_spec.singular_name%>_search.<%=f[:name]%>.load_selection_options(nested_and_authorized_scope)
<% end -%>        
      }
      format.xml  { render :xml => @<%= file_name %> }
    end
  end

  # GET /<%= table_name %>/1/edit
  def edit
    @<%= gen_spec.singular_name %> = authorized_scope.find(params[:id])
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>
    
    @title = "Edit #{@<%=gen_spec.singular_name%>.short_name}"
    load_form_drop_downs

    # Configure Partials and Layout Text
    @navigation_title = <%=gen_spec.plural_title.inspect%>
    @model_selector = <%=entry_model_selector.inspect%>
    @title = "Edit #{@<%=gen_spec.singular_name%>.short_name}"
  end

  # POST /<%= table_name %>
  # POST /<%= table_name %>.xml
  def create
    @<%=gen_spec.single_nam%> = <%= class_name %>.new(params[:<%= file_name %>])
<%  if gen_spec.nested_by -%>
    load_parent_resources
    
    @<%=gen_spec.single_nam%>.<%= gen_spec.nested_by[:key]%> = @<%= gen_spec.nested_by[:name]%>.id
<% end -%>

    respond_to do |format|
      if @<%= file_name %>.save
        flash[:notice] = '<%= class_name %> was successfully created.'

        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { render :xml => @<%= file_name %>, :status => :created, :location => @<%= file_name %> }
      else

        # Configure Partials and Layout Text
        @title = "New <%=gen_spec.singular_title%>"
        @navigation_title = <%=gen_spec.plural_title.inspect%>
        @model_selector = <%=index_model_selector.inspect%>

        format.html { render :action => "new" }
        format.xml  { render :xml => @<%= file_name %>.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /<%= table_name %>/1
  # PUT /<%= table_name %>/1.xml
  def update
    @<%= file_name %> = <%= class_name %>.find(params[:id])
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>


    respond_to do |format|
      if @<%= file_name %>.update_attributes(params[:<%= file_name %>])
        flash[:notice] = '<%= class_name %> was successfully updated.'
        format.html { redirect_to(@<%= file_name %>) }
        format.xml  { head :ok }              
      else
        # Configure Partials and Layout Text
        @navigation_title = <%=gen_spec.plural_title.inspect%>
        @model_selector = <%=entry_model_selector.inspect%>
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
<%  if gen_spec.nested_by -%>
    load_parent_resources
<% end -%>
    
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
  
  def authorized_scope
    # not implimented yet
    <%=gen_spec.model_name%>.scoped({})
  end
  
  def nested_scope
<%  if gen_spec.nested_by -%>
    return @<%=gen_spec.nested_by[:name]%>.<%=gen_spec.plural_name%>
<% else -%>
    return <%=gen_spec.model_name%>.scoped({})
<%end -%>    
  end

<%if gen_spec.nested_by and gen_spec.nested_by.length>0%>
  def load_parent_resources
    if params[:<%=gen_spec.nested_by[:key]%>]
      @<%=gen_spec.nested_by[:name]%> = <%=gen_spec.nested_by[:model]%>.find(params[:<%=gen_spec.nested_by[:key]%>])
    else
      @<%=gen_spec.nested_by[:name]%> = @<%=gen_spec.singular_name%>.<%=gen_spec.nested_by[:name]%>
    end
<%gen_spec.root_resources[1..-1].each_cons(2) do |child_spec,parent_spec| -%>
    @<%=parent_spec.singular_name%> = @<%=child_spec.singular_name%>.<%=parent_spec.singular_name%>
<%end -%>
  end
<%end%>

  def parent_resources
    [<%=gen_spec.root_resources.reverse.map{|r| "@#{r.singular_name}"}.join(",")%>]
  end

  def <%=gen_spec.singular_name%>_search
<%if gen_spec.nested_by and gen_spec.nested_by.length>0%>    
    context = @<%=gen_spec.nested_by[:name]%>.id
    @<%=gen_spec.singular_name%>_search ||= <%=gen_spec.model_name%>Search.new(session, context)
<%else%>
    context = ""
    @<%=gen_spec.singular_name%>_search ||= <%=gen_spec.model_name%>Search.new(session, context)
<%end%>    
  end
  
  def update_<%=gen_spec.singular_name%>_search
    <%=gen_spec.singular_name%>_search.update_with(params)
  end
  
  helper_method :<%=gen_spec.singular_name%>_search  
  helper_method :parent_resources
  
end
