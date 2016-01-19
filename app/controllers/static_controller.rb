class StaticController < ApplicationController
  def home
    #sql = "SELECT COUNT(*) FROM sos WHERE sos.wahlfb = '07';"
    #@fb = ActiveRecord::Base.connection.execute(sql).first["count"]
    #
    #sql = "Select * from lab LIMIT 1"
    #@result = ActiveRecord::Base.connection.execute(sql).first["stgnr"]
    #@result
    # => "11"
    #

    @nb = Lab.where(pstatus: 'NB', :pdatum => 1.years.ago..Date.today).group(:pdatum, :pnr).limit(20).count
    #@nb = Lab.where(pstatus: 'NB', :pdatum => 1.years.ago..Date.today).group(:pdatum, :stg).limit(10).count
    @nb.delete_if { |key, value| value.blank? || key.blank? }

    @fbs = Sos.group(:wahlfb).order("wahlfb").count
    @fbs_arr = ["Medien", "Bauwesen", "Agrarwirtschaft", "Sozis", "IuE", "Wirtschaft", "Maschinenwesen", "Studienkolleg"]
    @total = Sos.count

    start = Sos.order(:hssem).group(:hssem).limit(25).count
    rest = Sos.select(:hssem).offset(25).count
    @sos = start
    #@sos = start.merge({"Sonstige" => rest})
    #Sos.order(:hssem).select(:hssem).offset(15).count
    #=> {1 => 1000, 2 => 1500, 3 => 491, ... }
    #@sos[1] ==> 1000

    #@lab = Lab.first
    #@sos = Sos.first
    #@stg = Stg.first
  end

  def get_data_third
    fbs = Sos.group(:wahlfb).order("wahlfb").count
    values = fbs.values

    respond_to do |format|
      format.json do
        render json: {
          "name": "Fachbereiche",
          "children": [{
            "name": "Medien",
            "children": [{
              "name": "Medien StudG.1", "size": "#{values[0]}"
            }]
          }, {
            "name": "Maschinenwesen",
            "children": [{
              "name": "MaschW-StudG.1", "size": "#{values[1]}"
            }]
          }, {
            "name": "Agrarwirtschaft",
            "children": [{
              "name": "AgrarW StudG.1", "size": "#{values[2]}"
            }]
          }, {
            "name": "Sozis",
            "children": [{
              "name": "Soz.A. und Ges.", "size": "#{values[3]}"
            }]
          }, {
            "name": "IuE",
            "children": [{
              "name": "Informatik StudG.1", "size": "#{values[4]}"
            }]
          }]
        }
      end
    end
  end


  def get_data_second
    fbs = Sos.group(:wahlfb).order("wahlfb").count
    values = fbs.values

    respond_to do |format|
      format.json do
        render json: {
          "name": "Fachbereiche",
          "children": [{
            "name": "Medien", "size": "#{values[0]}"
          },{
            "name": "Maschinenwesen", "size": "#{values[1]}"
          },{
            "name": "Agrarwirtschaft", "size": "#{values[2]}"
          },{
            "name": "Soziale Arbeit", "size": "#{values[3]}"
          },{
            "name": "IuE", "size": "#{values[4]}"
          },{
            "name": "Wirtschaft", "size": "#{values[5]}"
          }
          ]
        }
      end
    end
  end

  def get_data
    respond_to do |format|
      format.json do
        render json:
          {
         "name": "Fachbereiche",
         "children": [
          {
           "name": "IuE",
           "children": [
            {
             "name": "IuE - STG1",
             "children": [
              {"name": "Semester 1", "size": 3938},
              {"name": "Semester 2", "size": 3812},
              {"name": "Semester 3", "size": 6714},
              {"name": "Semester 4", "size": 743}
             ]
            },
            {
             "name": "IuE - STG2",
             "children": [
              {"name": "Semester 1", "size": 3534},
              {"name": "Semester 2", "size": 5731},
              {"name": "Semester 3", "size": 7840},
              {"name": "Semester 4", "size": 5914},
              {"name": "Semester 5", "size": 3416}
             ]
            },
            {
              "name": "IuE - STG3",
              "children": [
                {"name": "Semester1", "size": 1995}]
            }
           ]
          },
          {
           "name": "Agrarwirtschaft",
           "children": [
            {"name": "AW - STG1", "size": 17010},
            {"name": "AW - STG2", "size": 18000},
            {"name": "AW - STG3", "size": 1041},
            {"name": "AW - STG4", "size": 5176},
            {"name": "AW - STG5", "size": 449},
            {"name": "AW - STG6", "size": 5593},
            {"name": "AW - STG7", "size": 5534},
            {"name": "AW - STG8", "size": 9201},
            {"name": "AW - STG9", "size": 19975},
            {"name": "AW - STG10", "size": 1116},
            {"name": "AW - STG11", "size": 6006}
           ]
          },
          {
           "name": "Maschinenwesen",
           "children": [
            {"name": "MW - STG1", "size": 8833},
            {"name": "MW - STG2", "size": 1732},
            {"name": "MW - STG3", "size": 1900},
            {"name": "MW - STG4", "size": 10000},
          ]
          },
          {
           "name": "Medien",
           "children": [
            {"name": "M - STG1", "size": 8833},
            {"name": "M - STG2", "size": 1732},
            {"name": "M - STG3", "size": 3623},
            {"name": "M - STG4", "size": 10066}
           ]
          },
          {
           "name": "Sozis",
           "children": [
            {"name": "SA - STG1", "size": 4116},
            {"name": "SA - STG2", "size": 4116},
            {"name": "SA - STG3", "size": 4116},
           ]
          },
          {
           "name": "Wirtschaft",
           "children": [
            {"name": "W - STG1", "size": 1082},
            {"name": "W - STG2", "size": 1336},
            {"name": "W - STG3", "size": 319},
            {"name": "W - STG4", "size": 10498},
            {"name": "W - STG5", "size": 2822},
            {"name": "W - STG6", "size": 9983},
            {"name": "W - STG7", "size": 2213},
            {"name": "W - STG8", "size": 1681}
           ]
          }
         ]
        }
      end
    end
  end
end

