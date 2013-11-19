
class Scorecard

  def initialize(scores)
    @scores = scores
  end

  def highest
    @scores.max
  end

  def lowest
    @scores.min
  end

  def average
    @scores.inject(0) {|total, num| total + num }/@scores.length
  end

  def histogram
    hash = {}
    @scores.each do |score|
      hash[score.to_s.to_sym] = @scores.count(score)
    end
    hash
  end

  def scores

  end


end
