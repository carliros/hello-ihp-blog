module Web.Routes where
import IHP.RouterPrelude ( AutoRoute )
import Generated.Types ()
import Web.Types ( StaticController, PostsController, CommentsController )

-- Generator Marker
instance AutoRoute StaticController
instance AutoRoute PostsController


instance AutoRoute CommentsController

