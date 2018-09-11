require 'rails_helper'

describe ApplicationHelper, type: :helper do
  describe '#active_tab' do
    context 'when the passed path include the request path' do
      let(:request) { double(:request, path: '/resources/main') }

      it "returns 'active'" do
        allow(helper).to receive(:request).and_return(request)

        expect(helper.active_tab('/resources/main')).to eq 'active'
      end
    end

    context 'when the passed path does not includes the request path' do
      let(:request) { double(:request, path: '/resources/main') }

      it "returns ''" do
        allow(helper).to receive(:request).and_return(request)

        expect(helper.active_tab('/resources/show')).to eq ''
      end
    end
  end

  describe '#doc_email' do
    context 'when the doc has many emails' do
      let(:doc) { double(:doc, emails: emails) }

      context 'when one email is marked as primary' do
        let(:emails) do
          [
            {'type' => 'primary', 'email' => 'primary@email.com'},
            {'type' => 'secundary', 'email' => 'secundary@email.com'}
          ]
        end

        it 'returns the primary email address' do
          expect(helper.doc_email(doc)).to eq 'primary@email.com'
        end
      end

      context 'when there is no email marked as primary' do
        let(:emails) do
          [
            {'type' => 'secundary', 'email' => 'secundary@email.com'},
            {'type' => 'third', 'email' => 'primary@email.com'}
          ]
        end

        it 'returns the first email address' do
          expect(helper.doc_email(doc)).to eq 'secundary@email.com'
        end
      end
    end

    context "when the doc hasn't many emails" do
      let(:doc) { double(:doc, emails: nil, email: 'email@email.com') }

      it 'returns the only email address' do
        expect(helper.doc_email(doc)).to eq 'email@email.com'
      end
    end
  end


  describe '#doc_type' do
    context "when doc hasn't profile" do
      let(:doc) { double(:doc, profile: nil) }

      it "returns '(unknown)'" do
        expect(helper.doc_type(doc)).to eq '(unknown)'
      end
    end

    context 'when doc has profile' do
      let(:doc) { double(:doc, profile: [profile]) }

      context "when profile's href matches the pattern" do
        let(:profile) { double(:doc, href: '/resources/main') }

        it "returns the last string splited by '/'" do
          expect(helper.doc_type(doc)).to eq 'main'
        end
      end

      context "when profile's href  doesn't matches the pattern" do
        let(:profile) { double(:doc, href: '') }

        it "returns '(unknown)'" do
          expect(helper.doc_type(doc)).to eq '(unknown)'
        end
      end
    end
  end

  describe 'format_time' do
    context 'parsing a DateTime' do
      it 'returns a string specifying how much time passed' do
        expect(helper.format_time(DateTime.current - 1.day)).to eq '1 day ago'
      end
    end

    context 'parsing a object different from a DateTime' do
      it "returns '(unknown)'" do
        expect(helper.format_time('Some string')).to eq '(unknown)'
      end
    end
  end
end
