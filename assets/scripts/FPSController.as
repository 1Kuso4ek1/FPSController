class FPSController
{
    FPSController(Model@ playerModel, float speed = 2.0)
    {
        @this.playerModel = @playerModel;
        @playerRB = @playerModel.GetRigidBody();
        this.speed = speed;
    }

    void Update()
    {
        playerModel.SetOrientation(Quaternion(0, 0, 0, 1));
        auto v = Game::camera.Move(1, true); v.y = 0; v *= 300;
        playerRB.applyWorldForceAtCenterOfMass(v);

        auto vel = playerRB.getLinearVelocity();
        if(vel.x > speed) vel.x = speed; if(vel.z > speed) vel.z = speed;
        if(vel.x < -speed) vel.x = -speed; if(vel.z < -speed) vel.z = -speed;
        playerRB.setLinearVelocity(vel);

        if(v == Vector3(0, 0, 0))
            playerRB.setLinearVelocity(
                Vector3(playerRB.getLinearVelocity().x / 1.5,
                        playerRB.getLinearVelocity().y,
                        playerRB.getLinearVelocity().z / 1.5));
    }

    private Model@ playerModel;
    private RigidBody@ playerRB;
    private float speed;
};