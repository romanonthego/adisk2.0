FactoryGirl.define do
	factory :user do |f|
		# f.name "Robinson"
		f.sequence(:email) { |n| "email#{n}@test.com"}
		f.password "secret123456"
		f.first_name Faker::Name.name
		f.last_name Faker::Name.name
		f.patronomic Faker::Name.name
		f.login Faker::Name.name.downcase
		f.roles []
		# f.deputies {|deputies| [deputies.association(:deputy)]}
		# f.subs {|subs| [subs.association(:subs)]}
	end

	factory :role do |r|
		r.name "user"
	end

	factory :deputy do |deputy|
		deputy.sub {|sub| sub.association(:sub)}
		deputy.appointive {|appointive| appointive.association(:appointive)}
		deputy.is_active false
	end

	factory :reverse_deputy, :class => "Deputy" do |deputy|
		deputy.sub {|sub| sub.association(:sub)}
		deputy.appointive {|appointive| appointive.association(:appointive)}
		deputy.is_active false
	end

	factory :active_deputy do |deputy|
		deputy.sub {|sub| sub.association(:sub)}
		deputy.appointive {|appointive| appointive.association(:appointive)}
		deputy.is_active true
	end

	factory :active_reverse_deputy, :class => "Deputy" do |deputy|
		deputy.sub {|sub| sub.association(:sub)}
		deputy.appointive {|appointive| appointive.association(:appointive)}
		deputy.is_active true
	end

	factory :sub, :class => User do |f|
		f.sequence(:email) { |n| "email#{n}@test.com"}
		f.password "secret"
		f.first_name "Robinson"
	end
	factory :appointive, :class => User do |f|
		f.sequence(:email) { |n| "email#{n}@test.com"}
		f.password "secret"
		f.first_name "Robinson"
	end
end