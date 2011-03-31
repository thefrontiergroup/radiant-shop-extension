class FormLineItem
  include Forms::Models::Extension
  include Shop::Models::FormExtension
  
  # line_item:
  #   process: add|update|remove
  
  def create
    @result ||= {}
    find_or_create_current_order
    
    case process
    when 'add'
      @result[:add]    = @order.add(line_item_item_id,line_item_quantity,line_item_item_type)
    when 'modify'
      if line_items.present?
        line_items.each do |id,values|
          @data[:line_item] = values
          @result[:modify] = @order.modify(line_item_id,line_item_quantity)
        end
      else
        @result[:modify] = @order.modify(line_item_id,line_item_quantity)
      end
    when 'remove'
      @result[:remove] = @order.remove(line_item_id)
    end
    
    @result
  end
  
  protected
  
  def process
    @config[:process]
  end

  def line_items
    @data[:line_items]
  end
  
  def line_item
    @data[:line_item]
  end
  
  def line_item_id
    line_item[:id]
  end
  
  def line_item_item_id
    line_item[:item_id]
  end
  
  def line_item_item_type
    line_item[:item_type]
  end
  
  def line_item_quantity
    line_item[:quantity]
  end
  
end
