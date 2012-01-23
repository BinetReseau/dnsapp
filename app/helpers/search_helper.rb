# encoding: utf-8

#Author: Johann-Michael THIEBAUT <johann.thiebaut@gmail.com>
#Handful methods for the search engine

module SearchHelper

  #Builds options from fields, field names and request params
  def search_options(fields, names, types, params)
    options = []

    for i in 0..(fields.length - 1)
      hash = { :field => fields[i], :name => names[i], :type => types[i], :value => params[fields[i].to_sym] }
      options.insert( -1, hash )
    end

    return options
  end

  #Builds a hash (:title, :conditions)
  #where :conditions is ready to pass to a find method
  #WARNING: Pay attention when modifying this method.
  #== It generates SQL statements.
  #== Always check you properly sanitize SQL statements.
  def searching_for(options, initial_conditions=[""])
    first = true
    title = ""
    conditions = [""]
    initial_string = initial_conditions[0]
    if !initial_conditions.blank?
      conditions = initial_conditions
      if initial_conditions[0] != ""
        conditions[0] = "#{initial_conditions[0]} and ("
        unmatched_parenthesis = true
      end
    end

    for i in 0..(options.length - 1)
      if !options[i][:value].blank?

        if options[i][:type] == "strict"
          if first
            title = "Résultats pour #{options[i][:name]} = #{options[i][:value]}"
            conditions[0] += "#{options[i][:field]} = ?"
            conditions.insert( -1, "#{options[i][:value]}" )
            first = false
          else
            title += " et #{options[i][:name]} = #{options[i][:value]}"
            conditions[0] += " and #{options[i][:field]} = ?"
            conditions.insert( -1, like )
          end
        elsif options[i][:type] == "like"
          like = "%#{options[i][:value]}%"

          if first
            title = "Résultats pour #{options[i][:name]} ~ #{options[i][:value]}"
            conditions[0] += "#{options[i][:field]} like ?"
            conditions.insert( -1, like )
            first = false
          else
            title += " et #{options[i][:name]} ~ #{options[i][:value]}"
            conditions[0] += " and #{options[i][:field]} like ?"
            conditions.insert( -1, like )
          end
        end
      end
    end

    if first
      title = ""
      conditions[0] = initial_string
    else
      conditions[0] += ")" if unmatched_parenthesis == true
    end

    return { :title => title, :conditions => conditions, :ic => initial_conditions }
  end

end