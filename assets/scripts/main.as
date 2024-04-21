FPSController@ player;

Clock time;

bool thirdPerson = false;

void Start()
{
    Game::manageCameraMovement = false;
	Game::camera.SetPosition(Vector3(0, 2.7, 0));
	
    @player = @FPSController(Game::scene.GetModel("player"), Game::scene.GetModelGroup("ground"), 12.0, 500.0);
}

void Loop()
{
    if(Keyboard::isKeyPressed(Keyboard::Q))
    {
        thirdPerson = !thirdPerson;
        Game::manageCameraLook = !thirdPerson;
        cast<Model>(player).SetIsDrawable(thirdPerson);
    }

    player.Update();

    float offset = (player.IsMoving() && player.IsOnGround() ? sin(time.getElapsedTime().asSeconds() * 20) * 0.1 : 0.0);
    float offset1 = (player.IsMoving() && player.IsOnGround() ? sin(time.getElapsedTime().asSeconds() * 10) * 0.1 : 0.0);

    if(!thirdPerson)
        Game::camera.SetPosition(cast<Model>(player).GetPosition() + Vector3(0.0, 1.3 + offset, 0.0) + Game::camera.GetOrientation() * Vector3(offset1, 0.0, 0.0));
    else
    {
        Game::camera.SetPosition(cast<Model>(player).GetPosition() + Vector3(0.0, 1.3, 0.0) + Game::camera.GetOrientation() * Vector3(0.0, 0.0, 8.0));
        Game::camera.Look(cast<Model>(player).GetPosition() + Vector3(0.0, 1.0, 0.0));
    }
}
