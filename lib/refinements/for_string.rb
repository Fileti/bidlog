module Refinements
  module ForString
    refine String do
      def email?
        !!(self =~ /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i)
      end
    end
  end
end