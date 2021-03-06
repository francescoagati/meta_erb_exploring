require 'rubygems'
require 'erb'

class TemplateProcessor
  
  def initialize(params={})
    params.each_pair do |k,v|
      instance_variable_set("@#{k}",v)
    end
    code=ERB.new(params[:tpl]).result(binding)
    
    params[:in_class].class_eval(code) if params[:in_class]
    params[:in_instance].instance_eval(code) if params[:in_instance]
    
  end
  
end

class My_class

end

obj={}

TemplateProcessor.new :nm => 'name', :tpl => %{
  def self.get_<%= @nm %>()
    return @<%= @nm %>
  end
  
  def self.set_<%= @nm %>(vl)
    @<%= @nm %>=vl
  end

}, :in_class => My_class


My_class.set_name(123)
p My_class.get_name()


TemplateProcessor.new :nm => 'name', :tpl => %{
  def self.get_<%= @nm %>()
    return @<%= @nm %>
  end
  
  def self.set_<%= @nm %>(vl)
    @<%= @nm %>=vl
  end

}, :in_instance => obj

obj.set_name(123)
p obj.get_name()

