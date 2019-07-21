## Review 1st 20190712 - Revision 4e87ab

1. Coding style thấy gớm quá. Ví dụ

    - app/assets/stylesheets/feed.scss

        * Lúc thì 1 tab là 4 spaces, lúc thì 1 tab là 2 space -> thống nhất 1 tab là 2 spaces thôi.

    ```
    body
    {
        margin: 0;
        padding: 0;
    }
    ```

    => ko ai viết css style vậy cả, cần viết như vầy

    ```
    body {
      margin: 0;
      padding: 0;
    }
    ```

    - config/routes.rb: line 10-11: indent nhìn lung tung quá. Lien 22 cũng vậy.
    Done !!!

2. Code dư thừa ko cần thiết

    - app/assets/stylesheets/feed.scss

    ```
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    ```

    => Giờ chẳng còn ai xài mấy cái browser firefox/chrome/safari đời khủng long ko support `border-radius` nữa, nên 2 dòng này là dư thừa

    - app/controllers/users/...: nếu ko cần modify controller của devise thì việc generate ra những controller này là ko cần thiết. Việc chỉ định controllers cho devise ở route cũng là dư thừa

    - app/controllers/photos_controller.r#set_photo: define ko thấy xài?
    - app/controllers/albums_controller.rb: trong controller này sao lại có `set_photo`

3. Chú ý cách đặt tên cho variable (biến).

    - app/controllers/photos_controller.rb#index: `@photo` là 1 collection thì đặt tên biến là số nhiều.
    - app/controllers/profile_controller.rb#index: tương tự trên (`@photo`, `@album`)
    - app/controllers/albums_controller.rb: tương tự trên

4. Sử dụng những tiện tích Rails hỗ trợ thay vì tự mình làm

    - app/controllers/photos_controller.rb

    ```
    @photo = Photo.new(photo_params)
    @photo.user_id = current_user.id
    ```

    => Tạo ra photo từ current_user luôn thay vì khởi tạo photo rồi sau đó mới gán user

    `@photo = current_user.photos.build(photo_params)`

    - app/controllers/photos_controller.rb#create: Validate cần implement trong model, ko làm manually trong controller như vậy

    ```
    if @photo.title.empty? | @photo.description.empty?
      flash[:warning] = "Title or Description was empty!"
      redirect_to new_photo_path
    else @photo.save
      flash[:success] = "Photo has been added"
      redirect_to profile_index_path
    end
    ```

    =>

    ```
    if @photo.save
      flash[:success] = "Photo has been added"
      redirect_to profile_index_path
    else @photo.save
      flash[:warning] = @photo.errors.full_messages.joins('. ')
      redirect_to :new
    end
    ```

    - app/controllers/albums_controller.rb: tương tự trên
    Done !!!
5. Hạn chế sử dụng inline css/js

    - app/views/albums/new.html.erb
    - app/views/feed/index.html.erb
    - ... các file view khác
    Done !!!

6. Sử dụng resource trong route. Hạn chế sử dụng custom route nếu ko cần thiết.

    - config/routes.rb: line 2-4
    Done !!!

7. Migration lỗi

8. Hạn chế sử dụng external assets => download những assets này về và đưa vào asset pipeline của Rails

    - app/views/layouts/application.html.erb
    Done !!!


## Review 1st 20190721 - Revision 0c931ac

1. Chú ý cách đặt tên cho variable (biến), method

    - app/controllers/albums_controller.rb#show, app/controllers/albums_controller.rb#create: `@albums` chỗ này `album` là single object chứ ko phải 1 collection, đặt tên biến số ít thôi.
    - app/controllers/albums_controller.rb#albums_params: tượng tự trên, name method này ko nên ở số nhiều.
    - app/controllers/info_profile_controller.rb#index: `@users`
    - app/controllers/photos_controller.rb: controller này cái name của `@photo` lần review trước chỉ sai ở action `index`, bữa nay sai hết ráo vây!
    - app/controllers/relationships_controller.rb


2. Code dư thừa:

    - app/controllers/albums_controller.rb#create: Ko thấy dùng ajax ở javascript sao trên controller có xử lý để trả về format json nữa? Có thật có chỗ dùng format này ko? Controller chỉ còn xử lý để trả về response cho format nào mà dưới client có dùng thôi, ko phải lúc nào cũng cần `respond_to` rồi trả nhiều format về.
    - app/controllers/relationships_controller.rb: format `js` ở controller này đang dùng ở đâu?

3. Coding style vẫn thấy ghê :|

    - app/controllers/feed_controller.rb#index: sau dấu `=` cần có 1 space
    - app/controllers/info_profile_controller.rb: sau dấu `=` chỗ thì 1 space, chỗ thì 2 spaces. Blank line tuỳ ngẫu hứng, ko thấy có sự consistent gì hết. Sau dấu `,` cần có 1 space
    - app/views/feed/index.html.erb: trước và sau Ruby embeded code cần có space. E.g: `<%=feed_index_path%>` => `<%= feed_index_path %>`

4. Code khó hiểu:

    - app/controllers/info_profile_controller.rb#index: `@users = User.find(params[:format])` => thường người ta `find` bởi `params[:id]`, hay `params[:user_id]` gì đó, ở đây dùng `params[:format]` nghe lạ lạ?
    - app/controllers/relationships_controller.rb: `before_action :logged_in_user` => method `logged_in_user` khai báo ở đâu vậy?

5. Không nên sửa dụng `.where.first` để tìm 1 record nào đó. Vì câu này sẽ perform 1 câu mệnh đề `order` ở database server ko cần thiết. Khi cần tìm 1 record thì dùng `find_by`.

    - app/controllers/info_profile_controller.rb#unfollow: `where(follower_id: current_user.id).where(following_id: params[:following_id]).first` => `find_by(follower_id: current_user.id, following_id: params[:following_id])`

6. Cần đảm bảo tính đúng đắn của dữ liệu

    - app/controllers/info_profile_controller.rb#follow: nên check xem `current_user` có follow thằng user đang muốn follow chưa, có rồi thì ignore request này đi, chưa có thì tiến hành follow. User nó có nhiều cách gởi request lên server mà vượt qua được validate ở dưới client, nên server cần check lại lần nữa để chắc chắn.

7. Chưa tận dụng được sức mạnh của ActiveRecord: association

    - app/controllers/info_profile_controller.rb#follow: `Follow.create(follower_id:  current_user.id,following_id: params[:following_id])` => `current_user.following_relationships.create(following_id: params[:following_id])`
    - app/controllers/info_profile_controller.rb#unfollow: `follow = Follow.where(follower_id: current_user.id).where(following_id: params[:following_id]).first` => `current_user.following_relationships.find_by(following_id: params[:following_id])`

8. Ko commit những file không dùng đến

    - app/helpers/info_profile_helper.rb
    - app/helpers/relationships_helper.rb
    - public/system/*
    - test/*

9. Với template fornat `html` thì nên sử dụng SLIM, format `js` thì sử dụng `erb`

10. Hạn chế sử dụng inline javascript, inline CSS, nên dùng asset pipeline của Rails

    - app/views/albums/new.html.erb
    - app/views/info_profile/index.html.erb
    - app/views/photos/new.html.erb
    - app/views/profile/edit.html.erb

11. Code tào lao
    - app/views/info_profile/index.html.erb: `current_user.following.include?(@users) == false` => bản thân method `include?` nó return về `true|false` rồi thì `if/unless` trên kết quả trả về chứ ai lại đi compare với `true|false` nữa.

12. Ko dùng thẻ `img` với attribute `source` là raw text như vậy được. Khi chạy ở mode production hay deploy lên heroku sẽ ko work. Cách làm này chỉ work ở local development environment

    - app/views/info_profile/index.html.erb

13. Sử dụng resource trong route. Hạn chế sử dụng custom route nếu ko cần thiết.

    - config/routes.rb: line 24-25