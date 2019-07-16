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
