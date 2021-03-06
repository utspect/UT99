//=============================================================================
// ShieldBeltEffect.
//=============================================================================
class ShieldBeltEffect extends Effects;

var Texture LowDetailTexture;

simulated function Destroyed()
{
	if ( bHidden && (Owner != None) )
		Owner.SetDefaultDisplayProperties();
	Super.Destroyed();
}

simulated function PostBeginPlay()
{
	if ( !Level.bHighDetailMode && ((Level.NetMode == NM_Standalone) || (Level.NetMode == NM_Client)) )
	{
		Timer();
		bHidden = true;
		SetTimer(1.0, true);
	}
}

simulated function Timer()
{
	bHidden = true;
	Owner.SetDisplayProperties(Owner.Style, LowDetailTexture, false, true);
}

simulated function Tick(float DeltaTime)
{
	if ( (Fatness > Default.Fatness) && (Level.NetMode != NM_DedicatedServer) )
		Fatness = Max(Default.Fatness, Fatness - 130 * DeltaTime );
	if ( Owner != None )
		if ( (bHidden != Owner.bHidden) && (Level.NetMode != NM_DedicatedServer) )
			bHidden = Owner.bHidden;
}

defaultproperties
{
     LowDetailTexture=Texture'UnrealShare.GoldSkin'
     bAnimByOwner=True
     bOwnerNoSee=True
     bNetTemporary=False
     bTrailerSameRotation=True
     Physics=PHYS_Trailer
     RemoteRole=ROLE_SimulatedProxy
     DrawType=DT_Mesh
     Style=STY_Translucent
     Texture=None
     ScaleGlow=0.500000
     AmbientGlow=64
     Fatness=157
     bUnlit=True
     bMeshEnviroMap=True
}
