# BRAKEMAN REPORT

| Application path                                 | Rails version | Brakeman version | Started at                | Duration         |
|--------------------------------------------------|---------------|------------------|---------------------------|------------------|
| /Users/johnson/workspace/rails-apps/checkers_app | 4.0.4         | 2.5.0            | 2014-05-02 17:05:47 -0400 | 0.857735 seconds |

| Checks performed                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| BasicAuth, ContentTag, CrossSiteScripting, DefaultRoutes, Deserialize, DetailedExceptions, DigestDoS, EscapeFunction, Evaluation, Execute, FileAccess, FilterSkipping, ForgerySetting, HeaderDoS, I18nXSS, JRubyXML, JSONParsing, LinkTo, LinkToHref, MailTo, MassAssignment, ModelAttrAccessible, ModelAttributes, ModelSerialize, NestedAttributes, NumberToCurrency, QuoteTableName, Redirect, RegexDoS, Render, RenderDoS, ResponseSplitting, SQL, SQLCVEs, SSLVerify, SafeBufferManipulation, SanitizeMethods, SelectTag, SelectVulnerability, Send, SendFile, SessionSettings, SimpleFormat, SingleQuotes, SkipBeforeFilter, StripTags, SymbolDoS, TranslateBug, UnsafeReflection, ValidationRegex, WithoutProtection, YAMLParsing |

### SUMMARY

| Scanned/Reported  | Total |
|-------------------|-------|
| Controllers       | 6     |
| Models            | 3     |
| Templates         | 28    |
| Errors            | 0     |
| Security Warnings | 0 (0) |



### CONTROLLERS

| Name                  | Parent                 | Includes                    | Routes                                                                            |
|-----------------------|------------------------|-----------------------------|-----------------------------------------------------------------------------------|
| ApplicationController | ActionController::Base | SessionsHelper, GamesHelper | [None]                                                                            |
| GamesController       | ApplicationController  | ActionController::Live      | destroy, index, join, myturn, new, play, rejoin, show, update, update_match_title |
| MovesController       | ApplicationController  |                             | [None]                                                                            |
| SessionsController    | ApplicationController  |                             | create, destroy, new                                                              |
| StaticPagesController | ApplicationController  |                             | about, contact, help                                                              |
| UsersController       | ApplicationController  |                             | create, edit, index, new, show, update                                            |

### TEMPLATES

games/_board

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] image_tag(@pieceImages["1"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [Escaped Output] image_tag(@pieceImages["2"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [Escaped Output] image_tag(@pieceImages["-1"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@pieceImages["-2"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@pieceImages["1"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] image_tag(@pieceImages["2"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] image_tag(@pieceImages["-1"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] image_tag(@pieceImages["-2"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] @turn                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] javascript_tag do; [Escaped Output] image_tag(@pieceImages["1"]);[Escaped Output] image_tag(@pieceImages["2"]);[Escaped Output] image_tag(@pieceImages["-1"]);[Escaped Output] image_tag(@pieceImages["-2"]);[Escaped Output] image_tag(@pieceImages["1"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["2"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["-1"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["-2"], :class => "dojoDndItem");[Escaped Output] @turn; end |
| [Escaped Output] render(partial => "matchtitle", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] content_tag(:div, "Wait for your turn", :class => "text-center alert alert-warning", :id => "game-message")                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] ("y" + (local y).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] ("x" + (local x).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] image_tag(@location, :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@location, :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@location)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |

games/_board.["GamesController#show", "Template:games/show"]

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] image_tag("pr.png")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] image_tag("kr.png")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] image_tag("pw.png")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] image_tag("kw.png")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] image_tag("pr.png", :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] image_tag("kr.png", :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] image_tag("pw.png", :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] image_tag("kw.png", :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] Game.find(params[:id]).get_turn_color(current_user)                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] javascript_tag do; [Escaped Output] image_tag("pr.png");[Escaped Output] image_tag("kr.png");[Escaped Output] image_tag("pw.png");[Escaped Output] image_tag("kw.png");[Escaped Output] image_tag("pr.png", :class => "dojoDndItem");[Escaped Output] image_tag("kr.png", :class => "dojoDndItem");[Escaped Output] image_tag("pw.png", :class => "dojoDndItem");[Escaped Output] image_tag("kw.png", :class => "dojoDndItem");[Escaped Output] Game.find(params[:id]).get_turn_color(current_user); end |
| [Escaped Output] render(partial => "matchtitle", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] content_tag(:div, "Wait for your turn", :class => "text-center alert alert-warning", :id => "game-message")                                                                                                                                                                                                                                                                                                                                                                                              |
| [Escaped Output] ("y" + (local y).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| [Escaped Output] ("x" + (local x).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| [Escaped Output] image_tag({ "1" => "pr.png", "2" => "kr.png", "-1" => "pw.png", "-2" => "kw.png" }[Game.find(params[:id]).fen_board_as_array[(local y)][(local x)].to_s], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                       |
| [Escaped Output] image_tag({ "1" => "pr.png", "2" => "kr.png", "-1" => "pw.png", "-2" => "kw.png" }[Game.find(params[:id]).fen_board_as_array[(local y)][(local x)].to_s], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                       |
| [Escaped Output] image_tag({ "1" => "pr.png", "2" => "kr.png", "-1" => "pw.png", "-2" => "kw.png" }[Game.find(params[:id]).fen_board_as_array[(local y)][(local x)].to_s])                                                                                                                                                                                                                                                                                                                                                |

games/_board.["Template:games/show"]

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] image_tag(@pieceImages["1"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [Escaped Output] image_tag(@pieceImages["2"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| [Escaped Output] image_tag(@pieceImages["-1"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@pieceImages["-2"])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] image_tag(@pieceImages["1"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] image_tag(@pieceImages["2"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] image_tag(@pieceImages["-1"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] image_tag(@pieceImages["-2"], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] @turn                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] javascript_tag do; [Escaped Output] image_tag(@pieceImages["1"]);[Escaped Output] image_tag(@pieceImages["2"]);[Escaped Output] image_tag(@pieceImages["-1"]);[Escaped Output] image_tag(@pieceImages["-2"]);[Escaped Output] image_tag(@pieceImages["1"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["2"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["-1"], :class => "dojoDndItem");[Escaped Output] image_tag(@pieceImages["-2"], :class => "dojoDndItem");[Escaped Output] @turn; end |
| [Escaped Output] render(partial => "matchtitle", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] content_tag(:div, "Wait for your turn", :class => "text-center alert alert-warning", :id => "game-message")                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] ("y" + (local y).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] ("x" + (local x).to_s)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] image_tag(@pieceImages[@board[(local y)][(local x)].to_s], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] image_tag(@pieceImages[@board[(local y)][(local x)].to_s], :class => "dojoDndItem")                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] image_tag(@pieceImages[@board[(local y)][(local x)].to_s])                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

games/_game

| Output                                                                                                                                       |
|----------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] game.id                                                                                                                     |
| [Escaped Output] "Red: #{game.red.name}" unless game.red.nil?                                                                                |
| [Escaped Output] "vs." if game.is_full?                                                                                                      |
| [Escaped Output] "White: #{game.white.name}" unless game.white.nil?                                                                          |
| [Escaped Output] "| Winner: #{game.winner.name}" unless game.winner.nil?                                                                      |
| [Escaped Output] link_to("Rejoin", rejoin_game_path(game), :class => "btn btn-medium btn-primary")                                           |
| [Escaped Output] link_to("Join", join_game_path(game), :class => "btn btn-medium btn-primary")                                               |
| [Escaped Output] link_to("Boxscore", game, :class => "btn btn-medium btn-primary")                                                           |
| [Escaped Output] link_to("delete", game, :method => :delete, :data => ({ :confirm => "You sure?" }), :class => "btn btn-medium btn-primary") |
| [Escaped Output] time_ago_in_words(game.created_at)                                                                                          |

games/_game_results

| Output                                                                   |
|--------------------------------------------------------------------------|
| [Escaped Output] @game.id                                                |
| [Escaped Output] "Red: #{@game.red.name}" unless @game.red.nil?          |
| [Escaped Output] "White: #{@game.white.name}" unless @game.white.nil?    |
| [Escaped Output] "Winner: #{@game.winner.name}" unless @game.winner.nil? |
| [Escaped Output] "Game Moves" if @moves.any?                             |
| [Escaped Output] render(action => @moves, {})                            |
| [Escaped Output] render(action => @moves, {})                            |

games/_game_results.["GamesController#show", "Template:games/show"]

| Output                                                                                                               |
|----------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] Game.find(params[:id]).id                                                                           |
| [Escaped Output] unless Game.find(params[:id]).red.nil? then; "Red: #{Game.find(params[:id]).red.name}";end          |
| [Escaped Output] unless Game.find(params[:id]).white.nil? then; "White: #{Game.find(params[:id]).white.name}";end    |
| [Escaped Output] unless Game.find(params[:id]).winner.nil? then; "Winner: #{Game.find(params[:id]).winner.name}";end |
| [Escaped Output] "Game Moves" if Game.find(params[:id]).moves.any?                                                   |
| [Escaped Output] render(action => Game.find(params[:id]).moves, {})                                                  |

games/_game_results.["Template:games/show"]

| Output                                                                   |
|--------------------------------------------------------------------------|
| [Escaped Output] @game.id                                                |
| [Escaped Output] "Red: #{@game.red.name}" unless @game.red.nil?          |
| [Escaped Output] "White: #{@game.white.name}" unless @game.white.nil?    |
| [Escaped Output] "Winner: #{@game.winner.name}" unless @game.winner.nil? |
| [Escaped Output] "Game Moves" if @moves.any?                             |
| [Escaped Output] render(action => @moves, {})                            |

games/_matchtitle

| Output                                                                                                                |
|-----------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] content_tag(:h3, "Red: #{@game.red.name} Vs. White: #{@game.white.name}", :id => "player-vs-player") |
| [Escaped Output] content_tag(:h3, "No opponent yet", :id => "player-vs-player")                                       |

games/_matchtitle.["GamesController#show", "Template:games/show", "Template:games/_board"]

| Output                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] content_tag(:h3, "Red: #{Game.find(params[:id]).red.name} Vs. White: #{Game.find(params[:id]).white.name}", :id => "player-vs-player") |
| [Escaped Output] content_tag(:h3, "No opponent yet", :id => "player-vs-player")                                                                         |

games/_matchtitle.["Template:games/_board"]

| Output                                                                                                                |
|-----------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] content_tag(:h3, "Red: #{@game.red.name} Vs. White: #{@game.white.name}", :id => "player-vs-player") |
| [Escaped Output] content_tag(:h3, "No opponent yet", :id => "player-vs-player")                                       |

games/_ongoing_game

| Output                                                                                    |
|-------------------------------------------------------------------------------------------|
| [Escaped Output] link_to("Rejoin", @ongoing_game, :class => "btn btn-medium btn-primary") |

games/index

| Output                                                                                                    |
|-----------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/user_info", {})                                                |
| [Escaped Output] render(partial => "shared/stats", {})                                                    |
| [Escaped Output] will_paginate                                                                            |
| [Escaped Output] render(action => (@games or "There are no completed games on record."), {})              |
| [Escaped Output] will_paginate                                                                            |
| [Escaped Output] link_to("New game", new_game_path, :class => "btn btn-medium btn-primary")               |
| [Escaped Output] (local game).id                                                                          |
| [Escaped Output] (local game).red.nil? ? ((local game).white.name) : ((local game).red.name)              |
| [Escaped Output] link_to("Join", join_game_path((local game).id), :class => "btn btn-medium btn-primary") |
| [Escaped Output] time_ago_in_words((local game).created_at)                                               |

games/index.["GamesController#index"]

| Output                                                                                                                                                                                                                                  |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/user_info", {})                                                                                                                                                                              |
| [Escaped Output] render(partial => "shared/stats", {})                                                                                                                                                                                  |
| [Escaped Output] will_paginate                                                                                                                                                                                                          |
| [Escaped Output] render(action => (Game.paginate(:page => (params[:page]), :per_page => 15).where("winner_id is not null").where("white_id is not null").where("red_id is not null") or "There are no completed games on record."), {}) |
| [Escaped Output] will_paginate                                                                                                                                                                                                          |

games/show

| Output                                                                                |
|---------------------------------------------------------------------------------------|
| [Escaped Output] content_tag(:h1, "Game Results") if @game.has_winner?                |
| [Escaped Output] content_tag(:h1, "Play!") if (@game.waiting? or @game.ongoing?)      |
| [Escaped Output] render(partial => "shared/user_info", {})                            |
| [Escaped Output] render(partial => "shared/stats", {})                                |
| [Escaped Output] render(partial => "board", {}) if (@game.waiting? or @game.ongoing?) |
| [Escaped Output] render(partial => "game_results", {}) if @game.has_winner?           |
| [Escaped Output] render(partial => "wait_mode", {}) if @game.waiting?                 |
| [Escaped Output] render(partial => "play_mode", {}) if @game.ongoing?                 |

games/show.["GamesController#show"]

| Output                                                                                                                            |
|-----------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] content_tag(:h1, "Game Results") if Game.find(params[:id]).has_winner?                                           |
| [Escaped Output] if (Game.find(params[:id]).waiting? or Game.find(params[:id]).ongoing?) then; content_tag(:h1, "Play!");end      |
| [Escaped Output] render(partial => "shared/user_info", {})                                                                        |
| [Escaped Output] render(partial => "shared/stats", {})                                                                            |
| [Escaped Output] if (Game.find(params[:id]).waiting? or Game.find(params[:id]).ongoing?) then; render(partial => "board", {});end |
| [Escaped Output] render(partial => "game_results", {}) if Game.find(params[:id]).has_winner?                                      |

games/update_match_title

| Output                                                                            |
|-----------------------------------------------------------------------------------|
| [Escaped Output] j(render(partial => "matchtitle", {}))                           |
| [Escaped Output] escape_javascript(render(partial => "matchtitle", {})).html_safe |

layouts/_footer

| Output                                            |
|---------------------------------------------------|
| [Escaped Output] link_to("Johnson", contact_path) |
| [Escaped Output] link_to("About", about_path)     |
| [Escaped Output] link_to("Contact", contact_path) |

layouts/_footer.["Template:layouts/application"]

| Output                                            |
|---------------------------------------------------|
| [Escaped Output] link_to("Johnson", contact_path) |
| [Escaped Output] link_to("About", about_path)     |
| [Escaped Output] link_to("Contact", contact_path) |

layouts/_header

| Output                                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] link_to("checkers game app", root_path, :id => "logo")                                                        |
| [Escaped Output] "active" if current_page?(root_path)                                                                          |
| [Escaped Output] link_to("Home", root_path)                                                                                    |
| [Escaped Output] "active" if current_page?(help_path)                                                                          |
| [Escaped Output] link_to("Rules", help_path)                                                                                   |
| [Escaped Output] "active" if current_page?(users_path)                                                                         |
| [Escaped Output] link_to("Users", users_path)                                                                                  |
| [Escaped Output] "active" if current_page?(games_path)                                                                         |
| [Escaped Output] link_to("Games", games_path)                                                                                  |
| [Escaped Output] if (current_page?(edit_user_path(current_user)) or current_page?(user_path(current_user))) then; "active";end |
| [Escaped Output] link_to("Profile", current_user)                                                                              |
| [Escaped Output] link_to("Settings", edit_user_path(current_user))                                                             |
| [Escaped Output] link_to("Sign out", signout_path, :method => "delete")                                                        |
| [Escaped Output] link_to("Sign in", signin_path)                                                                               |

layouts/_header.["Template:layouts/application"]

| Output                                                                                                                         |
|--------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] link_to("checkers game app", root_path, :id => "logo")                                                        |
| [Escaped Output] "active" if current_page?(root_path)                                                                          |
| [Escaped Output] link_to("Home", root_path)                                                                                    |
| [Escaped Output] "active" if current_page?(help_path)                                                                          |
| [Escaped Output] link_to("Rules", help_path)                                                                                   |
| [Escaped Output] "active" if current_page?(users_path)                                                                         |
| [Escaped Output] link_to("Users", users_path)                                                                                  |
| [Escaped Output] "active" if current_page?(games_path)                                                                         |
| [Escaped Output] link_to("Games", games_path)                                                                                  |
| [Escaped Output] if (current_page?(edit_user_path(current_user)) or current_page?(user_path(current_user))) then; "active";end |
| [Escaped Output] link_to("Profile", current_user)                                                                              |
| [Escaped Output] link_to("Settings", edit_user_path(current_user))                                                             |
| [Escaped Output] link_to("Sign out", signout_path, :method => "delete")                                                        |
| [Escaped Output] link_to("Sign in", signin_path)                                                                               |

layouts/application

| Output                                                                                                  |
|---------------------------------------------------------------------------------------------------------|
| [Escaped Output] favicon_link_tag                                                                       |
| [Escaped Output] full_title(yield(:title))                                                              |
| [Escaped Output] stylesheet_link_tag("application", :media => "all", "data-turbolinks-track" => (true)) |
| [Escaped Output] javascript_include_tag("application", "data-turbolinks-track" => (true))               |
| [Escaped Output] yield(:player)                                                                         |
| [Escaped Output] csrf_meta_tags                                                                         |
| [Escaped Output] render(partial => "layouts/shim", {})                                                  |
| [Escaped Output] render(partial => "layouts/header", {})                                                |
| [Escaped Output] (local key)                                                                            |
| [Escaped Output] (local value)                                                                          |
| [Escaped Output] yield                                                                                  |
| [Escaped Output] render(partial => "layouts/footer", {})                                                |
| [Escaped Output] debug(params) if Rails.env.development?                                                |

layouts/application.["GamesController#index"]

| Output                                                                                                  |
|---------------------------------------------------------------------------------------------------------|
| [Escaped Output] favicon_link_tag                                                                       |
| [Escaped Output] full_title(yield(:title))                                                              |
| [Escaped Output] stylesheet_link_tag("application", :media => "all", "data-turbolinks-track" => (true)) |
| [Escaped Output] javascript_include_tag("application", "data-turbolinks-track" => (true))               |
| [Escaped Output] yield(:player)                                                                         |
| [Escaped Output] csrf_meta_tags                                                                         |
| [Escaped Output] render(partial => "layouts/shim", {})                                                  |
| [Escaped Output] render(partial => "layouts/header", {})                                                |
| [Escaped Output] (local key)                                                                            |
| [Escaped Output] (local value)                                                                          |
| [Escaped Output] yield                                                                                  |
| [Escaped Output] render(partial => "layouts/footer", {})                                                |
| [Escaped Output] debug(params) if Rails.env.development?                                                |

moves/_move

| Output                                                                                  |
|-----------------------------------------------------------------------------------------|
| [Escaped Output] "Turn: #{move.turn} | Movetext: #{move.movetext} | Board: #{move.board}" |
| [Escaped Output] move.created_at                                                        |
| [Escaped Output] move.turn                                                              |
| [Escaped Output] move.movetext                                                          |
| [Escaped Output] move.board                                                             |
| [Escaped Output] move.created_at                                                        |

sessions/new

| Output                                                                                                                                                                                                                                                                                                                                                      |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] (local f).label(:name, "Username")                                                                                                                                                                                                                                                                                                         |
| [Escaped Output] (local f).text_field(:name)                                                                                                                                                                                                                                                                                                                |
| [Escaped Output] (local f).label(:password)                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] (local f).password_field(:password)                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] (local f).submit("Sign in", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                         |
| [Escaped Output] form_for(:session, :url => (sessions_path)) do; [Escaped Output] (local f).label(:name, "Username");[Escaped Output] (local f).text_field(:name);[Escaped Output] (local f).label(:password);[Escaped Output] (local f).password_field(:password);[Escaped Output] (local f).submit("Sign in", :class => "btn btn-large btn-primary"); end |
| [Escaped Output] link_to("Sign up now!", signup_path)                                                                                                                                                                                                                                                                                                       |

sessions/new.["SessionsController#new"]

| Output                                                                                                                                                                                                                                                                                                                                                                                    |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] FormBuilder.new.label(:name, "Username")                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] FormBuilder.new.text_field(:name)                                                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] FormBuilder.new.label(:password)                                                                                                                                                                                                                                                                                                                                         |
| [Escaped Output] FormBuilder.new.password_field(:password)                                                                                                                                                                                                                                                                                                                                |
| [Escaped Output] FormBuilder.new.submit("Sign in", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] form_for(:session, :url => (sessions_path)) do; [Escaped Output] FormBuilder.new.label(:name, "Username");[Escaped Output] FormBuilder.new.text_field(:name);[Escaped Output] FormBuilder.new.label(:password);[Escaped Output] FormBuilder.new.password_field(:password);[Escaped Output] FormBuilder.new.submit("Sign in", :class => "btn btn-large btn-primary"); end |
| [Escaped Output] link_to("Sign up now!", signup_path)                                                                                                                                                                                                                                                                                                                                     |

shared/_error_messages

| Output                                                  |
|---------------------------------------------------------|
| [Escaped Output] pluralize(@user.errors.count, "error") |
| [Escaped Output] (local msg)                            |

shared/_error_messages.["Template:users/edit"]

| Output                                                  |
|---------------------------------------------------------|
| [Escaped Output] pluralize(@user.errors.count, "error") |
| [Escaped Output] (local msg)                            |

shared/_error_messages.["UsersController#create", "Template:users/new"]

| Output                                                                  |
|-------------------------------------------------------------------------|
| [Escaped Output] pluralize(User.new(user_params).errors.count, "error") |
| [Escaped Output] (local msg)                                            |

shared/_error_messages.["UsersController#edit", "Template:users/edit"]

| Output                                                                   |
|--------------------------------------------------------------------------|
| [Escaped Output] pluralize(User.find(params[:id]).errors.count, "error") |
| [Escaped Output] (Unresolved Model).new                                  |

shared/_error_messages.["UsersController#new", "Template:users/new"]

| Output                                                     |
|------------------------------------------------------------|
| [Escaped Output] pluralize(User.new.errors.count, "error") |
| [Escaped Output] (local msg)                               |

shared/_stats

| Output                                   |
|------------------------------------------|
| [Escaped Output] current_user.win_count  |
| [Escaped Output] current_user.loss_count |

shared/_stats.["GamesController#index", "Template:games/index"]

| Output                                   |
|------------------------------------------|
| [Escaped Output] current_user.win_count  |
| [Escaped Output] current_user.loss_count |

shared/_stats.["Template:games/index"]

| Output                                   |
|------------------------------------------|
| [Escaped Output] current_user.win_count  |
| [Escaped Output] current_user.loss_count |

shared/_stats.["UsersController#show", "Template:users/show"]

| Output                                   |
|------------------------------------------|
| [Escaped Output] current_user.win_count  |
| [Escaped Output] current_user.loss_count |

shared/_user_info

| Output                                                    |
|-----------------------------------------------------------|
| [Escaped Output] current_user.name                        |
| [Escaped Output] link_to("view my profile", current_user) |

shared/_user_info.["Template:games/index"]

| Output                                                    |
|-----------------------------------------------------------|
| [Escaped Output] current_user.name                        |
| [Escaped Output] link_to("view my profile", current_user) |

static_pages/about

| Output                                                                            |
|-----------------------------------------------------------------------------------|
| [Escaped Output] link_to("wiki", "http://en.wikipedia.org/wiki/English_draughts") |

static_pages/about.["StaticPagesController#about"]

| Output                                                                            |
|-----------------------------------------------------------------------------------|
| [Escaped Output] link_to("wiki", "http://en.wikipedia.org/wiki/English_draughts") |

static_pages/contact

| Output                                   |
|------------------------------------------|
| [Escaped Output] mail_to("#", "Johnson") |

static_pages/contact.["StaticPagesController#contact"]

| Output                                   |
|------------------------------------------|
| [Escaped Output] mail_to("#", "Johnson") |

static_pages/home

| Output                                                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] @user.name                                                                                                                                       |
| [Escaped Output] render(partial => "shared/user_info", {})                                                                                                        |
| [Escaped Output] render(partial => "shared/stats", {})                                                                                                            |
| [Escaped Output] "Wins: #{@user.win_count} | Losses: #{@user.loss_count}"                                                                                          |
| [Escaped Output] link_to("New game", new_game_path, :class => "btn btn-medium btn-primary")                                                                       |
| [Escaped Output] "(#{@waiting_ongoing_games.count})" unless @waiting_ongoing_games.empty?                                                                         |
| [Escaped Output] (render(action => @waiting_ongoing_games, {}) or "You do not have any active games at the moment.")                                              |
| [Escaped Output] "(#{@games.count})" unless @games.empty?                                                                                                         |
| [Escaped Output] (render(action => @games, {}) or "There are no games you can join.")                                                                             |
| [Escaped Output] "(#{@games.count})" unless @games.empty?                                                                                                         |
| [Escaped Output] (render(action => @games, {}) or "There are no completed games on record.")                                                                      |
| [Escaped Output] link_to("Sign up now!", signup_path, :class => "btn btn-large btn-primary")                                                                      |
| [Escaped Output] link_to(image_tag("Norman_Bethune_checkers_1937.jpg", :alt => "Checkers", :class => "img-rounded"), "http://simple.wikipedia.org/wiki/Checkers") |

static_pages/home.["StaticPagesController#home"]

| Output                                                                                                                                                                                                            |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] current_user.name                                                                                                                                                                                |
| [Escaped Output] render(partial => "shared/user_info", {})                                                                                                                                                        |
| [Escaped Output] render(partial => "shared/stats", {})                                                                                                                                                            |
| [Escaped Output] link_to("New game", new_game_path, :class => "btn btn-medium btn-primary")                                                                                                                       |
| [Escaped Output] unless current_user.waiting_and_ongoing_games.empty? then; "(#{current_user.waiting_and_ongoing_games.count})";end                                                                               |
| [Escaped Output] (render(action => current_user.waiting_and_ongoing_games, {}) or "You do not have any active games at the moment.")                                                                              |
| [Escaped Output] unless Game.find(:all, :conditions => ({ :active => (false), :winner_id => (nil) })).empty? then; "(#{Game.find(:all, :conditions => ({ :active => (false), :winner_id => (nil) })).count})";end |
| [Escaped Output] (render(action => Game.find(:all, :conditions => ({ :active => (false), :winner_id => (nil) })), {}) or "There are no games you can join.")                                                      |
| [Escaped Output] link_to("Sign up now!", signup_path, :class => "btn btn-large btn-primary")                                                                                                                      |
| [Escaped Output] link_to(image_tag("Norman_Bethune_checkers_1937.jpg", :alt => "Checkers", :class => "img-rounded"), "http://simple.wikipedia.org/wiki/Checkers")                                                 |

users/_user

| Output                                                                                               |
|------------------------------------------------------------------------------------------------------|
| [Escaped Output] link_to(user.name, user)                                                            |
| [Escaped Output] user.win_count                                                                      |
| [Escaped Output] user.loss_count                                                                     |
| [Escaped Output] link_to("delete", user, :method => :delete, :data => ({ :confirm => "You sure?" })) |

users/edit

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/error_messages", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| [Escaped Output] (local f).label(:name, "Username")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] (local f).text_field(:name)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] (local f).label(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| [Escaped Output] (local f).password_field(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| [Escaped Output] (local f).label(:password_confirmation, "Confirm Password")                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] (local f).password_field(:password_confirmation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| [Escaped Output] (local f).submit("Save changes", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] form_for(@user) do; [Escaped Output] render(partial => "shared/error_messages", {});[Escaped Output] (local f).label(:name, "Username");[Escaped Output] (local f).text_field(:name);[Escaped Output] (local f).label(:password);[Escaped Output] (local f).password_field(:password);[Escaped Output] (local f).label(:password_confirmation, "Confirm Password");[Escaped Output] (local f).password_field(:password_confirmation);[Escaped Output] (local f).submit("Save changes", :class => "btn btn-large btn-primary"); end |

users/edit.["UsersController#edit"]

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/error_messages", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| [Escaped Output] FormBuilder.new.label(:name, "Username")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] FormBuilder.new.text_field(:name)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] FormBuilder.new.label(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| [Escaped Output] FormBuilder.new.password_field(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| [Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] FormBuilder.new.password_field(:password_confirmation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] FormBuilder.new.submit("Save changes", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] form_for(User.find(params[:id])) do; [Escaped Output] render(partial => "shared/error_messages", {});[Escaped Output] FormBuilder.new.label(:name, "Username");[Escaped Output] FormBuilder.new.text_field(:name);[Escaped Output] FormBuilder.new.label(:password);[Escaped Output] FormBuilder.new.password_field(:password);[Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password");[Escaped Output] FormBuilder.new.password_field(:password_confirmation);[Escaped Output] FormBuilder.new.submit("Save changes", :class => "btn btn-large btn-primary"); end |

users/index

| Output                                                     |
|------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/user_info", {}) |
| [Escaped Output] render(partial => "shared/stats", {})     |
| [Escaped Output] will_paginate                             |
| [Escaped Output] render(action => @users, {})              |
| [Escaped Output] will_paginate                             |

users/index.["UsersController#index"]

| Output                                                                                                                   |
|--------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/user_info", {})                                                               |
| [Escaped Output] render(partial => "shared/stats", {})                                                                   |
| [Escaped Output] will_paginate                                                                                           |
| [Escaped Output] render(action => User.paginate(:page => (params[:page]), :per_page => 15).where(:admin => (false)), {}) |
| [Escaped Output] will_paginate                                                                                           |

users/new

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/error_messages", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] (local f).label(:name, "Username")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| [Escaped Output] (local f).text_field(:name)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] (local f).label(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
| [Escaped Output] (local f).password_field(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| [Escaped Output] (local f).label(:password_confirmation, "Confirm Password")                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] (local f).password_field(:password_confirmation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| [Escaped Output] (local f).submit("Create my account", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] form_for(@user) do; [Escaped Output] render(partial => "shared/error_messages", {});[Escaped Output] (local f).label(:name, "Username");[Escaped Output] (local f).text_field(:name);[Escaped Output] (local f).label(:password);[Escaped Output] (local f).password_field(:password);[Escaped Output] (local f).label(:password_confirmation, "Confirm Password");[Escaped Output] (local f).password_field(:password_confirmation);[Escaped Output] (local f).submit("Create my account", :class => "btn btn-large btn-primary"); end |

users/new.["UsersController#create"]

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/error_messages", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] FormBuilder.new.label(:name, "Username")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| [Escaped Output] FormBuilder.new.text_field(:name)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] FormBuilder.new.label(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  |
| [Escaped Output] FormBuilder.new.password_field(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| [Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| [Escaped Output] FormBuilder.new.password_field(:password_confirmation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] FormBuilder.new.submit("Create my account", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| [Escaped Output] form_for(User.new(user_params)) do; [Escaped Output] render(partial => "shared/error_messages", {});[Escaped Output] FormBuilder.new.label(:name, "Username");[Escaped Output] FormBuilder.new.text_field(:name);[Escaped Output] FormBuilder.new.label(:password);[Escaped Output] FormBuilder.new.password_field(:password);[Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password");[Escaped Output] FormBuilder.new.password_field(:password_confirmation);[Escaped Output] FormBuilder.new.submit("Create my account", :class => "btn btn-large btn-primary"); end |

users/new.["UsersController#new"]

| Output                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] render(partial => "shared/error_messages", {})                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| [Escaped Output] FormBuilder.new.label(:name, "Username")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| [Escaped Output] FormBuilder.new.text_field(:name)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] FormBuilder.new.label(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| [Escaped Output] FormBuilder.new.password_field(:password)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| [Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| [Escaped Output] FormBuilder.new.password_field(:password_confirmation)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| [Escaped Output] FormBuilder.new.submit("Create my account", :class => "btn btn-large btn-primary")                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| [Escaped Output] form_for(User.new) do; [Escaped Output] render(partial => "shared/error_messages", {});[Escaped Output] FormBuilder.new.label(:name, "Username");[Escaped Output] FormBuilder.new.text_field(:name);[Escaped Output] FormBuilder.new.label(:password);[Escaped Output] FormBuilder.new.password_field(:password);[Escaped Output] FormBuilder.new.label(:password_confirmation, "Confirm Password");[Escaped Output] FormBuilder.new.password_field(:password_confirmation);[Escaped Output] FormBuilder.new.submit("Create my account", :class => "btn btn-large btn-primary"); end |

users/show

| Output                                                                                                        |
|---------------------------------------------------------------------------------------------------------------|
| [Escaped Output] @user.name                                                                                   |
| [Escaped Output] render(partial => "shared/user_info", {})                                                    |
| [Escaped Output] render(partial => "shared/stats", {})                                                        |
| [Escaped Output] "Wins: #{@user.win_count} | Losses: #{@user.loss_count}"                                      |
| [Escaped Output] "(#{@waiting_ongoing_games.count})" unless @waiting_ongoing_games.empty?                     |
| [Escaped Output] (render(action => @waiting_ongoing_games, {}) or "There are no active games at the moment.") |
| [Escaped Output] "(#{@games.count})" unless @games.empty?                                                     |
| [Escaped Output] (render(action => @games, {}) or "There are no completed games on record.")                  |

users/show.["UsersController#show"]

| Output                                                                                                                                                  |
|---------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Escaped Output] User.find(params[:id]).name                                                                                                            |
| [Escaped Output] render(partial => "shared/user_info", {})                                                                                              |
| [Escaped Output] render(partial => "shared/stats", {})                                                                                                  |
| [Escaped Output] "Wins: #{User.find(params[:id]).win_count} | Losses: #{User.find(params[:id]).loss_count}"                                              |
| [Escaped Output] unless User.find(params[:id]).waiting_and_ongoing_games.empty? then; "(#{User.find(params[:id]).waiting_and_ongoing_games.count})";end |
| [Escaped Output] (render(action => User.find(params[:id]).waiting_and_ongoing_games, {}) or "There are no active games at the moment.")                 |
| [Escaped Output] unless User.find(params[:id]).completed_games.empty? then; "(#{User.find(params[:id]).completed_games.count})";end                     |
| [Escaped Output] (render(action => User.find(params[:id]).completed_games, {}) or "There are no completed games on record.")                            |



