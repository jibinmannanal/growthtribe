class HomeController < ApplicationController
  def index
    @data = DATA
  end
  def show
    @data=nested_hash(DATA,params[:id].to_i)
  end

  def child_show
    @data, @parent_data = child_parent_hash(DATA,params[:tree_id].to_i,params[:id].to_i)
  end

  def parent_show
    @data, @parent_data = child_parent_hash(DATA,params[:tree_id].to_i,params[:id].to_i)

  end
  def nested_hash(obj,key)
    r ||= []


    if obj.is_a?(Hash)

if obj[:id]== key
      r.push(obj[:child])

else
      obj.each_value { |e| r += nested_hash(e,key) }
end
    end
    if obj.is_a?(Array)

      obj.each { |e| r += nested_hash(e,key) }
    end

    return   r
  end
  def child_parent_hash(obj,parent_id,child_id)
    r ||= []

    parent_data = obj if obj[:id]== parent_id

    if obj.is_a?(Hash)

      obj.each_value { |e| r += nested_hash(e,child_id) }

    end
    if obj.is_a?(Array)
      obj.each { |e| r += nested_hash(e,child_id) }
    end

    unless parent_data.blank?
      r= nested_hash(parent_data,child_id)
    end

    return   r, parent_data
  end


end
