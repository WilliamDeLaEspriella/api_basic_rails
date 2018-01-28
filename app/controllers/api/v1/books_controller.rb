class Api::V1::BooksController < ApplicationController
    def index
        book = Book.all
        render json: book, status: :ok
    end
    def show
        book = Book.find(params[:id])
        render json: book, status: :ok
    end
    def create
        book =Book.new(book_params)
        if book.save
            render json: book ,status: :created
        else
            render json: book.errors.full_messages, status: :unprocessable_entity
        end
    end
    def destroy
        book = Book.find(params[:id])
        if book.destroy
         render json: {"status":"success destroy"},status: :ok
        else
        render json:{"status":"fails destroy"},status: :not_acceptable
        end
    end 
    def update
        book = Book.find(params[:id])
        
        if book.update(book_params)
            render json: {"status":"success update"},status: :ok
           else
           render json:{"status":"fails update"},status: :not_acceptable
           end

    end

 private 
 
    def book_params
        params.require(:book).permit(:title,:description,:page)
    end
end
