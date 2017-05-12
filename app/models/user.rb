class User < ApplicationRecord
  require 'bcrypt'

  has_secure_password

  before_save { self.email = email.downcase }
  validates :first_name, :last_name, presence: true
  validates :username, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
  format: { with: VALID_EMAIL_REGEX },
  uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_many :games

  def top_score
    self.games.order(points: :desc).limit(1).first.points
  end

  def average_score
    self.games.map{|g| g.points}.reduce(:+)/self.games.count
  end

  def top_five_games
    self.games.order(points: :desc).limit(5)
  end

  def bar_chart
    games= self.games.select(:created_at, :points).limit(10)
    top_ten_games = []
    games.each do |game|
      top_ten_games.push({
        "label": game.created_at.strftime('%d  %b, %Y on %a'),
        "value": game.points
        })
      end

      @chart = Fusioncharts::Chart.new({
        :height => 400,
        :width => 600,
        :type => 'column2d',
        :renderAt => 'chart-container',
        :dataSource => {
        "chart": {
          "caption": "Top 10 Games",
          "xAxisname": "Game",
          "yAxisName": "Points",
          "numberPrefix": "",
          "theme": "fint"
        },
        "data": top_ten_games
        }
        })
      end
    end
