class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def send_simple_message
		RestClient.post "https://api:key-a43be3ae01bc19f2932af105f4d4725f"\
		"@api.mailgun.net/v3/sandboxd6f6aec4457f49808fc7599b87bff54f.mailgun.org/messages",
		:from => "Mailgun Sandbox <postmaster@sandboxd6f6aec4457f49808fc7599b87bff54f.mailgun.org>",
		:to => "Ho E Lin <dennisieur@hotmail.com>",
		:subject => "Hello Ho E Lin",
		:text => "Congratulations Ho E Lin, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
	end

	def index
		@posts = Post.all.order("created_at DESC")
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)

		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
