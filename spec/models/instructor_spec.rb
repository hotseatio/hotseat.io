# typed: false
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Instructor, type: :model do
  describe 'full label' do
    describe 'with first and last names' do
      it "combines an instructor's first and last names" do
        instructor = build :instructor, first_names: ['Paul'], last_names: ['Eggert']
        expect(instructor.full_label).to eq('Paul Eggert')
      end

      it 'can handle two people as one instructor' do
        instructor = build :instructor, first_names: ['Paul', 'David A.'], last_names: %w[Eggert Smallberg]
        expect(instructor.full_label).to eq('Paul Eggert and David A. Smallberg')
      end

      it 'can handle three people as one instructor' do
        instructor = build :instructor, first_names: ['Paul', 'David A.', 'Jens'], last_names: %w[Eggert Smallberg Palsberg]
        expect(instructor.full_label).to eq('Paul Eggert et al.')
      end
    end

    describe 'with registrar listing only' do
      it 'gives the registrar list if there is one' do
        instructor = build :instructor, registrar_listing: ['Eggert, P.R.']
        expect(instructor.full_label).to eq('Eggert, P.R.')
      end

      it 'can handle two-person listings' do
        instructor = build :instructor, registrar_listing: ['Eggert, P.R.', 'Smallberg, D.']
        expect(instructor.full_label).to eq('Eggert, P.R. and Smallberg, D.')
      end

      it 'can handle three-person listings' do
        instructor = build :instructor, registrar_listing: ['Eggert, P.R.', 'Smallberg, D.', 'Palsberg, J.']
        expect(instructor.full_label).to eq('Eggert, P.R. et al.')
      end
    end
  end
end
