require "amount"

class ChargesController < ApplicationController

  def new
    if current_user.standard?
      @stripe_btn_data = {
       key: "#{ Rails.configuration.stripe[:publishable_key] }",
       description: "BigMoney Membership - #{current_user.email}",
       amount: Amount.default
      }
    else
      flash[:notice] = "Only Standard role can be upgraded to Premium role. You already had #{current_user.role} role, so you do not need to upgrade your role."
      redirect_to edit_user_registration_path
    end
  end

  def create
       # Creates a Stripe Customer object, for associating
       # with the charge
       customer = Stripe::Customer.create(
         email: current_user.email,
         card: params[:stripeToken]
       )

       # Where the real magic happens
       charge = Stripe::Charge.create(
         customer: customer.id, # Note -- this is NOT the user_id in your app
         amount: Amount.default,
         description: "BigMoney Membership - #{current_user.email}",
         currency: 'usd'
       )

       # set current_user's role to Premium
       current_user.premium!
       flash[:notice] = "Thanks for all the money, #{current_user.email}! Feel free to pay me again."
       redirect_to edit_user_registration_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

  end
end
