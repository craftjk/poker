require 'poker/game'
require 'poker/card'
require 'poker/hand'
require 'poker/player'
require 'poker/deck'


describe 'Poker' do

  describe Card do
    subject(:card) { Card.new(:A, :S) }

    its(:value) { should eq :A }
    its(:suit) { should eq :S }
  end

  describe Player do

  end

  describe Deck do
    subject(:deck) { Deck.new }
    it "should return an array of 52 card objects" do
      deck.cards.count.should == 52
      expect(deck.cards.sample).to be_an_instance_of(Card)
    end

    describe '#deal_hand' do
      it "should return an array of 5 Card objects" do
        deck.deal_hand.count.should == 5
        expect(deck.deal_hand.sample).to be_an_instance_of(Card)
      end

      it "should remove dealt cards from the deck" do
        deck.deal_hand
        expect(deck.cards.count).to eq(47)
      end
    end
  end

  describe Hand do
    describe "high card" do
      it "recognizes a high card" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(5,:S),
          Card.new(3,:H),
          Card.new(4,:C),
          Card.new(7,:D)
          ] )

        expect(pair_hand.hand_type).to eq([:high_card, 7])
      end
    end

    describe "pair" do
      it "recognizes a pair" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(3,:H),
          Card.new(4,:C),
          Card.new(5,:D)
          ] )

        expect(pair_hand.hand_type).to eq([:pair, 2])
      end

      it "does not recognize a two pair" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(3,:H),
          Card.new(3,:C),
          Card.new(5,:D)
          ] )

        expect(pair_hand.hand_type[0]).not_to eq(:pair)
      end
    end

    describe "two pair" do
      it "recognizes two pairs" do
        two_pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(3,:H),
          Card.new(3,:C),
          Card.new(5,:D)
          ] )

        expect(two_pair_hand.hand_type).to eq([:two_pair, [2,3]])
      end

      it "does not recognize a three of a kind" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(2,:C),
          Card.new(3,:C),
          Card.new(5,:D)
          ] )

        expect(pair_hand.hand_type[0]).not_to eq(:two_pair)
      end
    end

    describe "three of a kind" do
      it "recognizes three of a kind" do
        two_pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(2,:C),
          Card.new(3,:C),
          Card.new(5,:D)
          ] )

        expect(two_pair_hand.hand_type).to eq([:three_kind, 2])
      end

      it "does not recognize a four of a kind" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(2,:C),
          Card.new(2,:D),
          Card.new(5,:D)
          ] )

        expect(pair_hand.hand_type[0]).not_to eq(:three_kind)
      end

      it "does not recognize a full house" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(3,:C),
          Card.new(3,:D),
          Card.new(3,:S)
          ] )

        expect(pair_hand.hand_type[0]).not_to eq(:three_kind)
      end
    end

    describe "full house" do
      it "recognizes a full house" do
        full_house_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(2,:C),
          Card.new(3,:C),
          Card.new(3,:D)
          ] )

        expect(full_house_hand.hand_type).to eq([:full_house, [3,2]])
      end

      it "does not recognize four of a kind" do
        pair_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(3,:H),
          Card.new(3,:C),
          Card.new(3,:D),
          Card.new(3,:S)
          ] )

        expect(pair_hand.hand_type[0]).not_to eq(:three_kind)
      end
    end

    describe "four of a kind" do
      it "recognizes four of a kind" do
        four_kind_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(2,:S),
          Card.new(2,:C),
          Card.new(2,:D),
          Card.new(3,:D)
          ] )

        expect(four_kind_hand.hand_type).to eq([:four_kind, 2])
      end
    end

    describe "straight" do
      it "recognizes straight" do
        straight_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(3,:S),
          Card.new(4,:C),
          Card.new(5,:D),
          Card.new(6,:D)
          ] )

        expect(straight_hand.hand_type).to eq([:straight, 6])
      end

      it "recognizes straight with low ace" do
        straight_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(3,:S),
          Card.new(4,:S),
          Card.new(5,:D),
          Card.new(14,:D)
          ] )

        expect(straight_hand.hand_type).to eq([:straight, 5])
      end
    end

    describe "flush" do
      it "recognizes a flush" do
        flush_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(3,:H),
          Card.new(4,:H),
          Card.new(5,:H),
          Card.new(5,:H)
          ] )

        expect(flush_hand.hand_type).to eq([:flush, 5])
      end
    end

    describe "straight flush" do
      it "recognizes a straight flush" do
        flush_hand = Hand.new( [
          Card.new(2,:H),
          Card.new(3,:H),
          Card.new(4,:H),
          Card.new(5,:H),
          Card.new(6,:H)
          ] )

        expect(flush_hand.hand_type).to eq([:straight_flush, 6])
      end
    end

    describe "royal flush" do
      it "recognizes a royal flush" do
        flush_hand = Hand.new( [
          Card.new(10,:H),
          Card.new(11,:H),
          Card.new(12,:H),
          Card.new(13,:H),
          Card.new(14,:H)
          ] )

        expect(flush_hand.hand_type).to eq([:royal_flush, 14])
      end
    end
  end

  describe Game do
  end
end
