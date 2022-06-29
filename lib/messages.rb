module Message
  def text(message_select, passable = nil)
    {
      load_or_new: "Would you like to load a game or start a new game?\ntype 'load' to load and 'new' to start a new game",
      replay: 'Would you like to play again? (y/n)',
      save: 'What would you like to save your game as?',
      saved: 'Game saved (;',
      choose_file: 'Choose from one of the saved files : ',
      saved_name: 'What is the name of your saved game?',
      no_file: 'NO FILE FOUND',
      game_loaded: 'Game loaded (;',
      your_name: "Player #{passable}, what is your name?",
      won: "#{passable} wins!",
      select_piece: "#{passable} select your piece",
      select_move: "#{passable} select your move",
      invalid_move: 'Invalid move, select your piece',
      in_check: "#{passable} is now in check! Be careful with your next move"
    }[message_select]
  end
end