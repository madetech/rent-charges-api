require 'rails_helper'

describe RentDetail, focus:true do
  let(:rent_detail_gateway) { spy }
  let(:fixed_data_gateway) { spy }
  let(:save_rent_detail) do
    described_class.new(rent_detail_gateway: rent_detail_gateway, fixed_data_gateway: fixed_data_gateway)
  end

  context 'given invalid rent detail' do
    it 'responds with a validation error' do
      rent_detail = {
        uprn:'',
        address:'',
        address_2:'',
        comments:'',
        rr_count:'',
        property_type:'',
        base_data_bed_size:'',
        bedroom_weight:'',
        mra_archetype:'',
        jan_1999_asset_values:'',
        formula_rent_prev_year:'',
        rent_cap_prev_year:'',
        current_rent_as_at_2407_of_prev_year:'',
        year:''
      }

      response = save_rent_detail.execute(rent_detail: rent_detail)

      expect(response).to(
          eq(
            successful: false,
            errors: %i[
              missing_uprn
              missing_address
              missing_address_2
              missing_rr_count
              missing_property_type
              missing_base_data_bed_size
              missing_bedroom_weight
              missing_mra_archetype
              missing_jan_1999_asset_values
              missing_formula_rent_prev_year
              missing_rent_cap_prev_year
              missing_current_rent_as_at_2407_of_prev_year
              missing_year
            ]
          )
        )
    end 
  end

  context 'given valid default rent details' do
    it 'stores the rent details' do
      allow(fixed_data_gateway).to receive(:get_rc_uplift_data) { -0.01 }
      rent_detail = {
      uprn:'UPRN1',
      address:'136 Southwark Street',
      address_2:'Southwark',
      comments:'',
      rr_count:1.00,
      property_type:'MSN',
      base_data_bed_size:2.00,
      bedroom_weight:1.00,
      mra_archetype:'Flats',
      jan_1999_asset_values:12000.00,
      formula_rent_prev_year:143.00,
      rent_cap_prev_year:143.00,
      current_rent_as_at_2407_of_prev_year:143.00,
      year:'2019-20'
    }
    save_rent_detail.execute(rent_detail: rent_detail)

    expect(rent_detail_gateway).to have_received(:save) do |detail|
      expect(detail[:uprn]).to eq('UPRN1')
      expect(detail[:address]).to eq('136 Southwark Street')
      expect(detail[:address_2]).to eq('Southwark')
      expect(detail[:comments]).to eq('')
      expect(detail[:rr_count]).to eq(1.00)
      expect(detail[:property_type]).to eq('MSN')
      expect(detail[:base_data_bed_size]).to eq(2.00)
      expect(detail[:bedroom_weight]).to eq(1.00)
      expect(detail[:mra_archetype]).to eq('Flats')
      expect(detail[:jan_1999_asset_values]).to eq(12000.00)
      expect(detail[:formula_rent_prev_year]).to eq(143.00)
      expect(detail[:rent_cap_prev_year]).to eq(143.00)
      expect(detail[:current_rent_as_at_2407_of_prev_year]).to eq(143.00) 
      expect(detail[:year]).to eq('2019-20') 
    end 
    end
  end

  context 'given rent details' do
    it 'calculates formulas' do
      allow(fixed_data_gateway).to receive(:get_rc_uplift_data) { -0.01 }
      rent_detail = {
        uprn:'UPRN2',
        formula_rent_prev_year: 108.03,
        current_rent_as_at_2407_of_prev_year: 108.04,
        rent_cap_prev_year:153.36
      }
      save_rent_detail.execute(rent_detail: rent_detail)

      expect(rent_detail_gateway).to have_received(:save) do |detail|
        expect(detail[:formula_rent_this_year]).to eq(106.95)
        expect(detail[:rent_cap_this_year]).to eq(151.83)
        expect(detail[:lower_of_formula_rent_or_cap]).to eq(106.95)
        expect(detail[:uprated_actual]).to eq(106.96)
        expect(detail[:cap_v_act_plus_2_pounds]).to eq(106.95)
        expect(detail[:act_minus_2_pounds]).to eq(106.95)
        expect(detail[:actual_rent_this_year]).to eq(106.96)
        expect(detail[:converged]).to eq('Yes')
        expect(detail[:difference_between_ar_and_fr]).to eq(-0.01)
        expect(detail[:full_year_forecast]).to eq(5561.90)
        expect(detail[:year_on_year_percentage_change]).to eq(-1.00)
        expect(detail[:actual_rent_greater_than_rent_cap]).to eq('No')
        expect(detail[:actual_rent_greater_than_formula_rent]).to eq('Yes')
      end 
    end 
  end 
end 