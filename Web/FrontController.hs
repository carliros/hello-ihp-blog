module Web.FrontController where

import IHP.RouterPrelude
    ( parseRoute, startPage, FrontController(..) )
import Web.Controller.Prelude
    ( setLayout,
      initAutoRefresh,
      parseRoute,
      startPage,
      InitControllerContext(..),
      FrontController(..),
      StaticController(WelcomeAction),
      WebApplication,
      PostsController )
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Posts ()
import Web.Controller.Static ()

instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @PostsController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
