class StaticController < ApplicationController
  def home
    #sql = "Select * from lab LIMIT 1"
    #@result = ActiveRecord::Base.connection.execute(sql)
    #@result.first["stgnr"]
    # => "11"
    #

    #@sos = Sos.order(:hssem).group(:hssem).limit(10).count
    start = Sos.order(:hssem).group(:hssem).limit(25).count
    rest = Sos.select(:hssem).offset(25).count
    @sos = start.merge({"Sonstige" => rest})
    #Sos.order(:hssem).select(:hssem).offset(15).count
    #=> {1 => 1000, 2 => 1500, 3 => 491, ... }
    #@sos[1] ==> 1000

    #@lab = Lab.first
    #@sos = Sos.first
    #@stg = Stg.first
  end
end
