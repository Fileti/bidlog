class BidPresenter
  attr_accessor :bid

  delegate :id, :obs, to: :bid

  alias_method :model, :bid

  def initialize bid
    @bid = bid
  end

  def bidders_excerpt
    @excerpt ||= bidders.map(&:name_or_email).join(', ')
  end

  def bidders
    @bidders ||= bid.bidders.map { |o| BidderPresenter.new(o) }
  end

  def winner?
    bid.winner.present?
  end

  def winner_name
    bid.winner.bidder.name.present? ? bid.winner.bidder.name : bid.winner.bidder.email
  end

  def awaiting_responses?
    !winner?
  end

  def number_of_awaiting_responses
    bid.responses.count
  end

  def responses_badge
    if(awaiting_responses?)
      helpers.content_tag(:span, number_of_awaiting_responses, class: 'badge')
    else
      ''
    end
  end

  def winner_chooser_title
    if winner?
      # TODO: Liskov
      "Vencedor deste bid: #{winner_name}"
    else
      'Escolher bid vencedor'
    end
  end

  def winner_chooser_class
    if winner?
      'btn btn-success btn-xs'
    else
      'btn btn-secondary btn-xs'
    end
  end

  # Duplicam o output por algum motivo!
  def link_to(mode, *params, &block)
    if(block.present?)
      helpers.link_to routes.send(mode, bid), *params, &block
    else
      txt = params.delete_at(0)
      helpers.link_to txt, routes.send(mode, bid), *params
    end
  end

  def link_to_edit *params, &block
    link_to :edit_bid_path, *params, &block
  end

  def link_to_delete *params, &block
    hash = { method: :delete, data: { confirm: 'Confirma remoção?' } }

    param_position = block.present? ? 0 : 1

    if params[param_position].is_a?(Hash)
      hash = hash.merge params[param_position] 
    end

    params[param_position] = hash

    link_to :bid_path, *params, &block
  end

private
  def helpers
    return @helpers if @helpers
    @helpers = ApplicationController.helpers
    @helpers.extend(ActionView::RoutingUrlFor)
    @helpers
  end

  def routes
    Rails.application.routes.url_helpers
  end
end