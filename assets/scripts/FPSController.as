class FPSController
{
    FPSController(Model@ playerModel, ModelGroup ground, float speed = 2.0, float jumpForce = 250.0, float accelerationForce = 250.0)
    {
        @this.playerModel = @playerModel;
        @playerRB = @playerModel.GetRigidBody();
        this.speed = speed;
        this.jumpForce = jumpForce;
        this.accelerationForce = accelerationForce;

        mat.setBounciness(0.01);
        mat.setFrictionCoefficient(0.05);

        SetGroundGroup(ground);

        playerRB.setAngularLockAxisFactor(Vector3(0, 0, 0));
        playerRB.setMaterial(mat);
    }

    void Update()
    {
        auto v = Game::camera.Move(1.0, true, true); v.y = 0; v *= accelerationForce;
        moving = v.length() > 0;

        UpdateIsOnGround();
        playerRB.applyWorldForceAtCenterOfMass(v);

        auto vel = playerRB.getLinearVelocity();
        if(vel.x > speed) vel.x = speed; if(vel.z > speed) vel.z = speed;
        if(vel.x < -speed) vel.x = -speed; if(vel.z < -speed) vel.z = -speed;
        playerRB.setLinearVelocity(vel);

        if(onGround)
            playerRB.setLinearVelocity(
                Vector3(playerRB.getLinearVelocity().x / 1.3,
                        playerRB.getLinearVelocity().y,
                        playerRB.getLinearVelocity().z / 1.3));

        if(Keyboard::isKeyPressed(Keyboard::Space))
        {
            if(onGround && canJump)
            {
                playerModel.GetRigidBody().applyWorldForceAtCenterOfMass(Vector3(0, jumpForce, 0) + Vector3(0, 0, (Game::camera.GetOrientation() * Vector3(0, 0, -250)).z));
                canJump = false;
            }
        }
        else if(onGround) canJump = true;
    }

    void UpdateIsOnGround()
    {
        Ray ray(playerModel.GetPosition(), playerModel.GetPosition() - Vector3(0, playerModel.GetSize().y + (!canJump ? 0.05 : 1), 0) + Vector3(0, 0, (Game::camera.GetOrientation() * Vector3(0, 0, (!canJump ? -0.05 : -0.5))).z));
        RaycastInfo info;

        int count = 0;
        for(uint i = 0; i < ground.Size(); i++)
        {
            if(!ground[i].IsLoaded()) continue;

            count += ground[i].GetRigidBody().raycast(ray, info) ? 1 : 0;
        }

        onGround = count > 0;
    }

    void SetGroundGroup(ModelGroup ground)
    {
        this.ground = ground;

        for(uint i = 0; i < ground.Size(); i++)
            ground[i].GetRigidBody().setMaterial(mat);
    }

    bool IsMoving()
    {
        return moving;
    }

    bool IsOnGround()
    {
        return onGround;
    }

    private PhysicalMaterial mat;

    private Model@ playerModel;
    private RigidBody@ playerRB;
    private float speed;
    private float jumpForce;
    private float accelerationForce;

    private ModelGroup ground;

    private bool canJump;
    private bool moving;
    private bool onGround;
};