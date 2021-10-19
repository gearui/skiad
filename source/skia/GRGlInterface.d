module skia.GRGlInterface;

import skia.DelegateProxies;
import skia.SKObject;
import skia.SkiaApi;
import skia.Definitions;

import std.experimental.logger;


// #if __TIZEN__
// using System.Reflection;
// #endif

class GRGlInterface : SKObject, ISKSkipObjectRegistration
{
	this (void* h, bool owns)
	{
    super (h, owns);
	}

	protected override void Dispose (bool disposing)
  {
    return 	super.Dispose (disposing);

  }
	
	// Create* (defaults)

	static GRGlInterface Create ()
  {
    return CreateGl () ? CreateGl () : CreateAngle ();
  }
		

	private static GRGlInterface CreateGl ()
	{
		// the native code will automatically return null on non-OpenGL platforms, such as UWP
		return GetObject (SkiaApi.gr_glinterface_create_native_interface ());
	}

	static GRGlInterface CreateAngle ()
	{
		// if (PlatformConfiguration.IsWindows) 
    // {
		// 	return CreateAngle (AngleLoader.GetProc);
		// } else {
		// 	// return null on non-DirectX platforms: everything except Windows
		// 	return null;
		// }
    	return null;
	}

	// Create* (assemble)

	static GRGlInterface Create (GRGlGetProcedureAddressDelegate get)
	{
		GRGlGetProcedureAddressDelegateWrapper wrapper = GRGlGetProcedureAddressDelegateWrapper(get);

		void* ctx = cast(void*)&wrapper;
		GRGlGetProcProxyDelegate releaseProxy = DelegateProxies.GRGlGetProcDelegateProxy;
		GRGlGetProcProxyDelegate proxy = DelegateProxies.Create (releaseProxy, ctx);

		try {
			return GetObject (SkiaApi.gr_glinterface_assemble_interface (cast(void*)ctx, proxy));
		} finally {

			// gch.Free ();
		}
	}

	static GRGlInterface CreateAngle (GRGlGetProcedureAddressDelegate get)
  {
    return 	CreateGles (get); // ANGLE is just a GLES v2 over DX v9+
  }
	

	static GRGlInterface CreateOpenGl (GRGlGetProcedureAddressDelegate get)
	{
		GRGlGetProcedureAddressDelegateWrapper wrapper = GRGlGetProcedureAddressDelegateWrapper(get);

		void* ctx = cast(void*)&wrapper;
		GRGlGetProcProxyDelegate releaseProxy = DelegateProxies.GRGlGetProcDelegateProxy;
		GRGlGetProcProxyDelegate proxy = DelegateProxies.Create (releaseProxy, ctx);
		try {
			return GetObject (SkiaApi.gr_glinterface_assemble_gl_interface (cast(void*)ctx, proxy));
		} finally {
		}
	}

	static GRGlInterface CreateGles (GRGlGetProcedureAddressDelegate get)
	{
		GRGlGetProcedureAddressDelegateWrapper wrapper = GRGlGetProcedureAddressDelegateWrapper(get);

		void* ctx = cast(void*)&wrapper;
		GRGlGetProcProxyDelegate releaseProxy = DelegateProxies.GRGlGetProcDelegateProxy;
		GRGlGetProcProxyDelegate proxy = DelegateProxies.Create (releaseProxy, ctx);

		try {
			return GetObject (SkiaApi.gr_glinterface_assemble_gles_interface (cast(void*)ctx, proxy));
		} finally {
		}
	}

	static GRGlInterface CreateWebGl (GRGlGetProcedureAddressDelegate get)
	{
		GRGlGetProcedureAddressDelegateWrapper wrapper = GRGlGetProcedureAddressDelegateWrapper(get);

		void* ctx = cast(void*)&wrapper;
		GRGlGetProcProxyDelegate releaseProxy = DelegateProxies.GRGlGetProcDelegateProxy;
		GRGlGetProcProxyDelegate proxy = DelegateProxies.Create (releaseProxy, ctx);

		try {
			return GetObject (SkiaApi.gr_glinterface_assemble_webgl_interface (cast(void*)ctx, proxy));
		} finally {
		}
	}

	static GRGlInterface CreateEvas (void* evas)
	{
		return null;
// #if __TIZEN__
// 		auto evasLoader = new EvasGlLoader (evas);
// 		return CreateGles (name => evasLoader.GetFunctionPointer (name));
// #else
// 		return null;
// #endif
	}

	// OBSOLETE CREATION

	static GRGlInterface CreateDefaultInterface (){
    return 	Create ();
  }
	

	static GRGlInterface CreateNativeGlInterface ()	{
		return CreateGl ();
	}
	
	static GRGlInterface CreateNativeAngleInterface ()	{
		return CreateAngle ();
	}
	
	static GRGlInterface CreateNativeEvasInterface (void* evas)	{
		return CreateEvas (evas);
	}
	
	static GRGlInterface AssembleInterface (GRGlGetProcDelegate get)	{
		return Create ((name){ return get(null, name);});
	}
	
	static GRGlInterface AssembleInterface (void* context, GRGlGetProcDelegate get)	{
		return Create ((name){return get(context, name);});
	}
	
	static GRGlInterface AssembleAngleInterface (GRGlGetProcDelegate get)	{
		return CreateAngle ((name){ return  get(null, name);});
	}
	
	static GRGlInterface AssembleAngleInterface (void* context, GRGlGetProcDelegate get)	{
		return CreateAngle ((name){return  get(context, name);});
	}
	
	static GRGlInterface AssembleGlInterface (GRGlGetProcDelegate get)	{
		return CreateOpenGl ((name) {return  get(null, name);});
	}
	
	static GRGlInterface AssembleGlInterface (void* context, GRGlGetProcDelegate get)	{
		return CreateOpenGl ((name){return  get(context, name);});
	}
	
	static GRGlInterface AssembleGlesInterface (GRGlGetProcDelegate get)	{
		return CreateGles ((name){return  get(null, name);});
	}
	
	static GRGlInterface AssembleGlesInterface (void* context, GRGlGetProcDelegate get)	{
		return CreateGles ((name){return  get(context, name);});
	}
	
	//

	bool Validate ()	{
		return SkiaApi.gr_glinterface_validate (cast(gr_glinterface_t*)Handle);
	}
	
	bool HasExtension (string extension)	{
		return SkiaApi.gr_glinterface_has_extension (cast(gr_glinterface_t*)Handle, extension);
	}
	
	//

	static GRGlInterface GetObject (void* handle)
  {
    return 	handle is null ? null : new GRGlInterface (handle, true);
  }
	

	//

	private static class AngleLoader
	{
		private static const void* libEGL;
		private static const void* libGLESv2;

// #if WINDOWS_UWP
// 		// https://msdn.microsoft.com/en-us/library/windows/desktop/mt186421(v=vs.85).aspx
// 		private static extern void* LoadPackagedLibrary ([MarshalAs (UnmanagedType.LPWStr)] string lpFileName, uint Reserved);
// 		private static extern void* GetProcAddress (void* hModule, [MarshalAs (UnmanagedType.LPStr)] string lpProcName);

// 		private static void* LoadLibrary (string lpFileName) => LoadPackagedLibrary(lpFileName, 0);
// #else
// 		private static extern void* LoadLibrary ([MarshalAs (UnmanagedType.LPStr)] string lpFileName);
// 		private static extern void* GetProcAddress (void* hModule, [MarshalAs (UnmanagedType.LPStr)] string lpProcName);
// #endif
		// private static extern void* eglGetProcAddress ([MarshalAs (UnmanagedType.LPStr)] string procname);

		// static AngleLoader()
		// {
		// 	// this is not supported at all on non-Windows platforms
		// 	if (!PlatformConfiguration.IsWindows) {
		// 		return;
		// 	}

		// 	libEGL = LoadLibrary ("libEGL.dll");
		// 	libGLESv2 = LoadLibrary ("libGLESv2.dll");
		// }

		static bool IsValid()
    {
      return libEGL !is null && libGLESv2 !is null;

    }
			
		// function to assemble the ANGLE interface
		static void* GetProc (string name)
		{
			// // this is not supported at all on non-Windows platforms
			// if (!PlatformConfiguration.IsWindows) {
			// 	return null;
			// }

			// if (!IsValid)
			// 	return null;

			// void* proc = GetProcAddress (libGLESv2, name);
			// if (proc is null)
			// {
			// 	proc = GetProcAddress (libEGL, name);
			// }
			// if (proc is null)
			// {
			// 	proc = eglGetProcAddress (name);
			// }
			// return proc;
      return null;
		}
	}

// #if __TIZEN__
// 	private class EvasGlLoader
// 	{
// 		private const string libevas = "libevas.so.1";

// 		private static const Type IntPtrType;
// 		private static const Type EvasGlApiType;
// 		private static const FieldInfo[] apiFields;

// 		private const void* glEvas;
// 		private const EvasGlApi api;
// 		static extern void* evas_gl_api_get (void* evas_gl);
// 		static extern void* evas_gl_context_api_get (void* evas_gl, void* ctx);
// 		static extern void* evas_gl_current_context_get (void* evas_gl);
// 		static extern void* evas_gl_proc_address_get (void* evas_gl, string name);

// 		static EvasGlLoader ()
// 		{
// 			IntPtrType = typeof (void*);
// 			EvasGlApiType = typeof (EvasGlApi);
// 			apiFields = EvasGlApiType.GetFields (BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance);
// 		}

// 		EvasGlLoader (void* evas)
// 		{
// 			glEvas = evas;
// 			auto glContext = evas_gl_current_context_get (glEvas);

// 			auto apiPtr = glContext !is null
// 				? evas_gl_context_api_get (glEvas, glContext)
// 				: evas_gl_api_get (glEvas);

// 			api = Marshal.PtrToStructure<EvasGlApi> (apiPtr);
// 		}

// 		void* GetFunctionPointer (string name)
// 		{
// 			// try evas_gl_proc_address_get
// 			auto address = evas_gl_proc_address_get (glEvas, name);
// 			if (address !is null)
// 				return address;

// 			// try the API struct
// 			for (var i = 0; i < apiFields.Length; i++) {
// 				auto field = apiFields[i];
// 				if (field.Name == name && field.FieldType == IntPtrType)
// 					return (void*)field.GetValue (api);
// 			}

// 			return null;
// 		}
// 	}

// 	// this structure is initialized from a native pointer
// 	private struct EvasGlApi
// 	{
// 		// DO NOT change the order, needs to be as specified in struct _Evas_GL_API (/platform/upstream/efl/src/lib/evas/Evas_GL.h)
// 		// DO NOT change the names, they need to match the OpenGL API
// #pragma warning disable 0169
// 		private int version;
// 		private void* glActiveTexture;
// 		private void* glAttachShader;
// 		private void* glBindAttribLocation;
// 		private void* glBindBuffer;
// 		private void* glBindFramebuffer;
// 		private void* glBindRenderbuffer;
// 		private void* glBindTexture;
// 		private void* glBlendColor;
// 		private void* glBlendEquation;
// 		private void* glBlendEquationSeparate;
// 		private void* glBlendFunc;
// 		private void* glBlendFuncSeparate;
// 		private void* glBufferData;
// 		private void* glBufferSubData;
// 		private void* glCheckFramebufferStatus;
// 		private void* glClear;
// 		private void* glClearColor;
// 		private void* glClearDepthf;
// 		private void* glClearStencil;
// 		private void* glColorMask;
// 		private void* glCompileShader;
// 		private void* glCompressedTexImage2D;
// 		private void* glCompressedTexSubImage2D;
// 		private void* glCopyTexImage2D;
// 		private void* glCopyTexSubImage2D;
// 		private void* glCreateProgram;
// 		private void* glCreateShader;
// 		private void* glCullFace;
// 		private void* glDeleteBuffers;
// 		private void* glDeleteFramebuffers;
// 		private void* glDeleteProgram;
// 		private void* glDeleteRenderbuffers;
// 		private void* glDeleteShader;
// 		private void* glDeleteTextures;
// 		private void* glDepthFunc;
// 		private void* glDepthMask;
// 		private void* glDepthRangef;
// 		private void* glDetachShader;
// 		private void* glDisable;
// 		private void* glDisableVertexAttribArray;
// 		private void* glDrawArrays;
// 		private void* glDrawElements;
// 		private void* glEnable;
// 		private void* glEnableVertexAttribArray;
// 		private void* glFinish;
// 		private void* glFlush;
// 		private void* glFramebufferRenderbuffer;
// 		private void* glFramebufferTexture2D;
// 		private void* glFrontFace;
// 		private void* glGenBuffers;
// 		private void* glGenerateMipmap;
// 		private void* glGenFramebuffers;
// 		private void* glGenRenderbuffers;
// 		private void* glGenTextures;
// 		private void* glGetActiveAttrib;
// 		private void* glGetActiveUniform;
// 		private void* glGetAttachedShaders;
// 		private void* glGetAttribLocation;
// 		private void* glGetBooleanv;
// 		private void* glGetBufferParameteriv;
// 		private void* glGetError;
// 		private void* glGetFloatv;
// 		private void* glGetFramebufferAttachmentParameteriv;
// 		private void* glGetIntegerv;
// 		private void* glGetProgramiv;
// 		private void* glGetProgramInfoLog;
// 		private void* glGetRenderbufferParameteriv;
// 		private void* glGetShaderiv;
// 		private void* glGetShaderInfoLog;
// 		private void* glGetShaderPrecisionFormat;
// 		private void* glGetShaderSource;
// 		private void* glGetString;
// 		private void* glGetTexParameterfv;
// 		private void* glGetTexParameteriv;
// 		private void* glGetUniformfv;
// 		private void* glGetUniformiv;
// 		private void* glGetUniformLocation;
// 		private void* glGetVertexAttribfv;
// 		private void* glGetVertexAttribiv;
// 		private void* glGetVertexAttribPointerv;
// 		private void* glHint;
// 		private void* glIsBuffer;
// 		private void* glIsEnabled;
// 		private void* glIsFramebuffer;
// 		private void* glIsProgram;
// 		private void* glIsRenderbuffer;
// 		private void* glIsShader;
// 		private void* glIsTexture;
// 		private void* glLineWidth;
// 		private void* glLinkProgram;
// 		private void* glPixelStorei;
// 		private void* glPolygonOffset;
// 		private void* glReadPixels;
// 		private void* glReleaseShaderCompiler;
// 		private void* glRenderbufferStorage;
// 		private void* glSampleCoverage;
// 		private void* glScissor;
// 		private void* glShaderBinary;
// 		private void* glShaderSource;
// 		private void* glStencilFunc;
// 		private void* glStencilFuncSeparate;
// 		private void* glStencilMask;
// 		private void* glStencilMaskSeparate;
// 		private void* glStencilOp;
// 		private void* glStencilOpSeparate;
// 		private void* glTexImage2D;
// 		private void* glTexParameterf;
// 		private void* glTexParameterfv;
// 		private void* glTexParameteri;
// 		private void* glTexParameteriv;
// 		private void* glTexSubImage2D;
// 		private void* glUniform1f;
// 		private void* glUniform1fv;
// 		private void* glUniform1i;
// 		private void* glUniform1iv;
// 		private void* glUniform2f;
// 		private void* glUniform2fv;
// 		private void* glUniform2i;
// 		private void* glUniform2iv;
// 		private void* glUniform3f;
// 		private void* glUniform3fv;
// 		private void* glUniform3i;
// 		private void* glUniform3iv;
// 		private void* glUniform4f;
// 		private void* glUniform4fv;
// 		private void* glUniform4i;
// 		private void* glUniform4iv;
// 		private void* glUniformMatrix2fv;
// 		private void* glUniformMatrix3fv;
// 		private void* glUniformMatrix4fv;
// 		private void* glUseProgram;
// 		private void* glValidateProgram;
// 		private void* glVertexAttrib1f;
// 		private void* glVertexAttrib1fv;
// 		private void* glVertexAttrib2f;
// 		private void* glVertexAttrib2fv;
// 		private void* glVertexAttrib3f;
// 		private void* glVertexAttrib3fv;
// 		private void* glVertexAttrib4f;
// 		private void* glVertexAttrib4fv;
// 		private void* glVertexAttribPointer;
// 		private void* glViewport;
// 		private void* glEvasGLImageTargetTexture2DOES;
// 		private void* glEvasGLImageTargetRenderbufferStorageOES;
// 		private void* glGetProgramBinaryOES;
// 		private void* glProgramBinaryOES;
// 		private void* glMapBufferOES;
// 		private void* glUnmapBufferOES;
// 		private void* glGetBufferPointervOES;
// 		private void* glTexImage3DOES;
// 		private void* glTexSubImage3DOES;
// 		private void* glCopyTexSubImage3DOES;
// 		private void* glCompressedTexImage3DOES;
// 		private void* glCompressedTexSubImage3DOES;
// 		private void* glFramebufferTexture3DOES;
// 		private void* glGetPerfMonitorGroupsAMD;
// 		private void* glGetPerfMonitorCountersAMD;
// 		private void* glGetPerfMonitorGroupStringAMD;
// 		private void* glGetPerfMonitorCounterStringAMD;
// 		private void* glGetPerfMonitorCounterInfoAMD;
// 		private void* glGenPerfMonitorsAMD;
// 		private void* glDeletePerfMonitorsAMD;
// 		private void* glSelectPerfMonitorCountersAMD;
// 		private void* glBeginPerfMonitorAMD;
// 		private void* glEndPerfMonitorAMD;
// 		private void* glGetPerfMonitorCounterDataAMD;
// 		private void* glDiscardFramebufferEXT;
// 		private void* glMultiDrawArraysEXT;
// 		private void* glMultiDrawElementsEXT;
// 		private void* glDeleteFencesNV;
// 		private void* glGenFencesNV;
// 		private void* glIsFenceNV;
// 		private void* glTestFenceNV;
// 		private void* glGetFenceivNV;
// 		private void* glFinishFenceNV;
// 		private void* glSetFenceNV;
// 		private void* glGetDriverControlsQCOM;
// 		private void* glGetDriverControlStringQCOM;
// 		private void* glEnableDriverControlQCOM;
// 		private void* glDisableDriverControlQCOM;
// 		private void* glExtGetTexturesQCOM;
// 		private void* glExtGetBuffersQCOM;
// 		private void* glExtGetRenderbuffersQCOM;
// 		private void* glExtGetFramebuffersQCOM;
// 		private void* glExtGetTexLevelParameterivQCOM;
// 		private void* glExtTexObjectStateOverrideiQCOM;
// 		private void* glExtGetTexSubImageQCOM;
// 		private void* glExtGetBufferPointervQCOM;
// 		private void* glExtGetShadersQCOM;
// 		private void* glExtGetProgramsQCOM;
// 		private void* glExtIsProgramBinaryQCOM;
// 		private void* glExtGetProgramBinarySourceQCOM;
// 		private void* evasglCreateImage;
// 		private void* evasglDestroyImage;
// 		private void* evasglCreateImageForContext;
// 		private void* glAlphaFunc;
// 		private void* glClipPlanef;
// 		private void* glColor4f;
// 		private void* glFogf;
// 		private void* glFogfv;
// 		private void* glFrustumf;
// 		private void* glGetClipPlanef;
// 		private void* glGetLightfv;
// 		private void* glGetMaterialfv;
// 		private void* glGetTexEnvfv;
// 		private void* glLightModelf;
// 		private void* glLightModelfv;
// 		private void* glLightf;
// 		private void* glLightfv;
// 		private void* glLoadMatrixf;
// 		private void* glMaterialf;
// 		private void* glMaterialfv;
// 		private void* glMultMatrixf;
// 		private void* glMultiTexCoord4f;
// 		private void* glNormal3f;
// 		private void* glOrthof;
// 		private void* glPointParameterf;
// 		private void* glPointParameterfv;
// 		private void* glPointSize;
// 		private void* glPointSizePointerOES;
// 		private void* glRotatef;
// 		private void* glScalef;
// 		private void* glTexEnvf;
// 		private void* glTexEnvfv;
// 		private void* glTranslatef;
// 		private void* glAlphaFuncx;
// 		private void* glClearColorx;
// 		private void* glClearDepthx;
// 		private void* glClientActiveTexture;
// 		private void* glClipPlanex;
// 		private void* glColor4ub;
// 		private void* glColor4x;
// 		private void* glColorPointer;
// 		private void* glDepthRangex;
// 		private void* glDisableClientState;
// 		private void* glEnableClientState;
// 		private void* glFogx;
// 		private void* glFogxv;
// 		private void* glFrustumx;
// 		private void* glGetClipPlanex;
// 		private void* glGetFixedv;
// 		private void* glGetLightxv;
// 		private void* glGetMaterialxv;
// 		private void* glGetPointerv;
// 		private void* glGetTexEnviv;
// 		private void* glGetTexEnvxv;
// 		private void* glGetTexParameterxv;
// 		private void* glLightModelx;
// 		private void* glLightModelxv;
// 		private void* glLightx;
// 		private void* glLightxv;
// 		private void* glLineWidthx;
// 		private void* glLoadIdentity;
// 		private void* glLoadMatrixx;
// 		private void* glLogicOp;
// 		private void* glMaterialx;
// 		private void* glMaterialxv;
// 		private void* glMatrixMode;
// 		private void* glMultMatrixx;
// 		private void* glMultiTexCoord4x;
// 		private void* glNormal3x;
// 		private void* glNormalPointer;
// 		private void* glOrthox;
// 		private void* glPointParameterx;
// 		private void* glPointParameterxv;
// 		private void* glPointSizex;
// 		private void* glPolygonOffsetx;
// 		private void* glPopMatrix;
// 		private void* glPushMatrix;
// 		private void* glRotatex;
// 		private void* glSampleCoveragex;
// 		private void* glScalex;
// 		private void* glShadeModel;
// 		private void* glTexCoordPointer;
// 		private void* glTexEnvi;
// 		private void* glTexEnvx;
// 		private void* glTexEnviv;
// 		private void* glTexEnvxv;
// 		private void* glTexParameterx;
// 		private void* glTexParameterxv;
// 		private void* glTranslatex;
// 		private void* glVertexPointer;
// 		private void* glBlendEquationSeparateOES;
// 		private void* glBlendFuncSeparateOES;
// 		private void* glBlendEquationOES;
// 		private void* glDrawTexsOES;
// 		private void* glDrawTexiOES;
// 		private void* glDrawTexxOES;
// 		private void* glDrawTexsvOES;
// 		private void* glDrawTexivOES;
// 		private void* glDrawTexxvOES;
// 		private void* glDrawTexfOES;
// 		private void* glDrawTexfvOES;
// 		private void* glAlphaFuncxOES;
// 		private void* glClearColorxOES;
// 		private void* glClearDepthxOES;
// 		private void* glClipPlanexOES;
// 		private void* glColor4xOES;
// 		private void* glDepthRangexOES;
// 		private void* glFogxOES;
// 		private void* glFogxvOES;
// 		private void* glFrustumxOES;
// 		private void* glGetClipPlanexOES;
// 		private void* glGetFixedvOES;
// 		private void* glGetLightxvOES;
// 		private void* glGetMaterialxvOES;
// 		private void* glGetTexEnvxvOES;
// 		private void* glGetTexParameterxvOES;
// 		private void* glLightModelxOES;
// 		private void* glLightModelxvOES;
// 		private void* glLightxOES;
// 		private void* glLightxvOES;
// 		private void* glLineWidthxOES;
// 		private void* glLoadMatrixxOES;
// 		private void* glMaterialxOES;
// 		private void* glMaterialxvOES;
// 		private void* glMultMatrixxOES;
// 		private void* glMultiTexCoord4xOES;
// 		private void* glNormal3xOES;
// 		private void* glOrthoxOES;
// 		private void* glPointParameterxOES;
// 		private void* glPointParameterxvOES;
// 		private void* glPointSizexOES;
// 		private void* glPolygonOffsetxOES;
// 		private void* glRotatexOES;
// 		private void* glSampleCoveragexOES;
// 		private void* glScalexOES;
// 		private void* glTexEnvxOES;
// 		private void* glTexEnvxvOES;
// 		private void* glTexParameterxOES;
// 		private void* glTexParameterxvOES;
// 		private void* glTranslatexOES;
// 		private void* glIsRenderbufferOES;
// 		private void* glBindRenderbufferOES;
// 		private void* glDeleteRenderbuffersOES;
// 		private void* glGenRenderbuffersOES;
// 		private void* glRenderbufferStorageOES;
// 		private void* glGetRenderbufferParameterivOES;
// 		private void* glIsFramebufferOES;
// 		private void* glBindFramebufferOES;
// 		private void* glDeleteFramebuffersOES;
// 		private void* glGenFramebuffersOES;
// 		private void* glCheckFramebufferStatusOES;
// 		private void* glFramebufferRenderbufferOES;
// 		private void* glFramebufferTexture2DOES;
// 		private void* glGetFramebufferAttachmentParameterivOES;
// 		private void* glGenerateMipmapOES;
// 		private void* glCurrentPaletteMatrixOES;
// 		private void* glLoadPaletteFromModelViewMatrixOES;
// 		private void* glMatrixIndexPointerOES;
// 		private void* glWeightPointerOES;
// 		private void* glQueryMatrixxOES;
// 		private void* glDepthRangefOES;
// 		private void* glFrustumfOES;
// 		private void* glOrthofOES;
// 		private void* glClipPlanefOES;
// 		private void* glGetClipPlanefOES;
// 		private void* glClearDepthfOES;
// 		private void* glTexGenfOES;
// 		private void* glTexGenfvOES;
// 		private void* glTexGeniOES;
// 		private void* glTexGenivOES;
// 		private void* glTexGenxOES;
// 		private void* glTexGenxvOES;
// 		private void* glGetTexGenfvOES;
// 		private void* glGetTexGenivOES;
// 		private void* glGetTexGenxvOES;
// 		private void* glBindVertexArrayOES;
// 		private void* glDeleteVertexArraysOES;
// 		private void* glGenVertexArraysOES;
// 		private void* glIsVertexArrayOES;
// 		private void* glCopyTextureLevelsAPPLE;
// 		private void* glRenderbufferStorageMultisampleAPPLE;
// 		private void* glResolveMultisampleFramebufferAPPLE;
// 		private void* glFenceSyncAPPLE;
// 		private void* glIsSyncAPPLE;
// 		private void* glDeleteSyncAPPLE;
// 		private void* glClientWaitSyncAPPLE;
// 		private void* glWaitSyncAPPLE;
// 		private void* glGetInteger64vAPPLE;
// 		private void* glGetSyncivAPPLE;
// 		private void* glMapBufferRangeEXT;
// 		private void* glFlushMappedBufferRangeEXT;
// 		private void* glRenderbufferStorageMultisampleEXT;
// 		private void* glFramebufferTexture2DMultisampleEXT;
// 		private void* glGetGraphicsResetStatusEXT;
// 		private void* glReadnPixelsEXT;
// 		private void* glGetnUniformfvEXT;
// 		private void* glGetnUniformivEXT;
// 		private void* glTexStorage1DEXT;
// 		private void* glTexStorage2DEXT;
// 		private void* glTexStorage3DEXT;
// 		private void* glTextureStorage1DEXT;
// 		private void* glTextureStorage2DEXT;
// 		private void* glTextureStorage3DEXT;
// 		private void* glClipPlanefIMG;
// 		private void* glClipPlanexIMG;
// 		private void* glRenderbufferStorageMultisampleIMG;
// 		private void* glFramebufferTexture2DMultisampleIMG;
// 		private void* glStartTilingQCOM;
// 		private void* glEndTilingQCOM;
// 		private void* evasglCreateSync;
// 		private void* evasglDestroySync;
// 		private void* evasglClientWaitSync;
// 		private void* evasglSignalSync;
// 		private void* evasglGetSyncAttrib;
// 		private void* evasglWaitSync;
// 		private void* evasglBindWaylandDisplay;
// 		private void* evasglUnbindWaylandDisplay;
// 		private void* evasglQueryWaylandBuffer;
// 		private void* glBeginQuery;
// 		private void* glBeginTransformFeedback;
// 		private void* glBindBufferBase;
// 		private void* glBindBufferRange;
// 		private void* glBindSampler;
// 		private void* glBindTransformFeedback;
// 		private void* glBindVertexArray;
// 		private void* glBlitFramebuffer;
// 		private void* glClearBufferfi;
// 		private void* glClearBufferfv;
// 		private void* glClearBufferiv;
// 		private void* glClearBufferuiv;
// 		private void* glClientWaitSync;
// 		private void* glCompressedTexImage3D;
// 		private void* glCompressedTexSubImage3D;
// 		private void* glCopyBufferSubData;
// 		private void* glCopyTexSubImage3D;
// 		private void* glDeleteQueries;
// 		private void* glDeleteSamplers;
// 		private void* glDeleteSync;
// 		private void* glDeleteTransformFeedbacks;
// 		private void* glDeleteVertexArrays;
// 		private void* glDrawArraysInstanced;
// 		private void* glDrawBuffers;
// 		private void* glDrawElementsInstanced;
// 		private void* glDrawRangeElements;
// 		private void* glEndQuery;
// 		private void* glEndTransformFeedback;
// 		private void* glFenceSync;
// 		private void* glFlushMappedBufferRange;
// 		private void* glFramebufferTextureLayer;
// 		private void* glGenQueries;
// 		private void* glGenSamplers;
// 		private void* glGenTransformFeedbacks;
// 		private void* glGenVertexArrays;
// 		private void* glGetActiveUniformBlockiv;
// 		private void* glGetActiveUniformBlockName;
// 		private void* glGetActiveUniformsiv;
// 		private void* glGetBufferParameteri64v;
// 		private void* glGetBufferPointerv;
// 		private void* glGetFragDataLocation;
// 		private void* glGetInteger64i_v;
// 		private void* glGetInteger64v;
// 		private void* glGetIntegeri_v;
// 		private void* glGetInternalformativ;
// 		private void* glGetProgramBinary;
// 		private void* glGetQueryiv;
// 		private void* glGetQueryObjectuiv;
// 		private void* glGetSamplerParameterfv;
// 		private void* glGetSamplerParameteriv;
// 		private void* glGetStringi;
// 		private void* glGetSynciv;
// 		private void* glGetTransformFeedbackVarying;
// 		private void* glGetUniformBlockIndex;
// 		private void* glGetUniformIndices;
// 		private void* glGetUniformuiv;
// 		private void* glGetVertexAttribIiv;
// 		private void* glGetVertexAttribIuiv;
// 		private void* glInvalidateFramebuffer;
// 		private void* glInvalidateSubFramebuffer;
// 		private void* glIsQuery;
// 		private void* glIsSampler;
// 		private void* glIsSync;
// 		private void* glIsTransformFeedback;
// 		private void* glIsVertexArray;
// 		private void* glMapBufferRange;
// 		private void* glPauseTransformFeedback;
// 		private void* glProgramBinary;
// 		private void* glProgramParameteri;
// 		private void* glReadBuffer;
// 		private void* glRenderbufferStorageMultisample;
// 		private void* glResumeTransformFeedback;
// 		private void* glSamplerParameterf;
// 		private void* glSamplerParameterfv;
// 		private void* glSamplerParameteri;
// 		private void* glSamplerParameteriv;
// 		private void* glTexImage3D;
// 		private void* glTexStorage2D;
// 		private void* glTexStorage3D;
// 		private void* glTexSubImage3D;
// 		private void* glTransformFeedbackVaryings;
// 		private void* glUniform1ui;
// 		private void* glUniform1uiv;
// 		private void* glUniform2ui;
// 		private void* glUniform2uiv;
// 		private void* glUniform3ui;
// 		private void* glUniform3uiv;
// 		private void* glUniform4ui;
// 		private void* glUniform4uiv;
// 		private void* glUniformBlockBinding;
// 		private void* glUniformMatrix2x3fv;
// 		private void* glUniformMatrix3x2fv;
// 		private void* glUniformMatrix2x4fv;
// 		private void* glUniformMatrix4x2fv;
// 		private void* glUniformMatrix3x4fv;
// 		private void* glUniformMatrix4x3fv;
// 		private void* glUnmapBuffer;
// 		private void* glVertexAttribDivisor;
// 		private void* glVertexAttribI4i;
// 		private void* glVertexAttribI4iv;
// 		private void* glVertexAttribI4ui;
// 		private void* glVertexAttribI4uiv;
// 		private void* glVertexAttribIPointer;
// 		private void* glWaitSync;
// 		private void* glDispatchCompute;
// 		private void* glDispatchComputeIndirect;
// 		private void* glDrawArraysIndirect;
// 		private void* glDrawElementsIndirect;
// 		private void* glFramebufferParameteri;
// 		private void* glGetFramebufferParameteriv;
// 		private void* glGetProgramInterfaceiv;
// 		private void* glGetProgramResourceIndex;
// 		private void* glGetProgramResourceName;
// 		private void* glGetProgramResourceiv;
// 		private void* glGetProgramResourceLocation;
// 		private void* glUseProgramStages;
// 		private void* glActiveShaderProgram;
// 		private void* glCreateShaderProgramv;
// 		private void* glBindProgramPipeline;
// 		private void* glDeleteProgramPipelines;
// 		private void* glGenProgramPipelines;
// 		private void* glIsProgramPipeline;
// 		private void* glGetProgramPipelineiv;
// 		private void* glProgramUniform1i;
// 		private void* glProgramUniform2i;
// 		private void* glProgramUniform3i;
// 		private void* glProgramUniform4i;
// 		private void* glProgramUniform1ui;
// 		private void* glProgramUniform2ui;
// 		private void* glProgramUniform3ui;
// 		private void* glProgramUniform4ui;
// 		private void* glProgramUniform1f;
// 		private void* glProgramUniform2f;
// 		private void* glProgramUniform3f;
// 		private void* glProgramUniform4f;
// 		private void* glProgramUniform1iv;
// 		private void* glProgramUniform2iv;
// 		private void* glProgramUniform3iv;
// 		private void* glProgramUniform4iv;
// 		private void* glProgramUniform1uiv;
// 		private void* glProgramUniform2uiv;
// 		private void* glProgramUniform3uiv;
// 		private void* glProgramUniform4uiv;
// 		private void* glProgramUniform1fv;
// 		private void* glProgramUniform2fv;
// 		private void* glProgramUniform3fv;
// 		private void* glProgramUniform4fv;
// 		private void* glProgramUniformMatrix2fv;
// 		private void* glProgramUniformMatrix3fv;
// 		private void* glProgramUniformMatrix4fv;
// 		private void* glProgramUniformMatrix2x3fv;
// 		private void* glProgramUniformMatrix3x2fv;
// 		private void* glProgramUniformMatrix2x4fv;
// 		private void* glProgramUniformMatrix4x2fv;
// 		private void* glProgramUniformMatrix3x4fv;
// 		private void* glProgramUniformMatrix4x3fv;
// 		private void* glValidateProgramPipeline;
// 		private void* glGetProgramPipelineInfoLog;
// 		private void* glBindImageTexture;
// 		private void* glGetBooleani_v;
// 		private void* glMemoryBarrier;
// 		private void* glMemoryBarrierByRegion;
// 		private void* glTexStorage2DMultisample;
// 		private void* glGetMultisamplefv;
// 		private void* glSampleMaski;
// 		private void* glGetTexLevelParameteriv;
// 		private void* glGetTexLevelParameterfv;
// 		private void* glBindVertexBuffer;
// 		private void* glVertexAttribFormat;
// 		private void* glVertexAttribIFormat;
// 		private void* glVertexAttribBinding;
// 		private void* glVertexBindingDivisor;
// 		private void* glBlendBarrier;
// 		private void* glCopyImageSubData;
// 		private void* glDebugMessageControl;
// 		private void* glDebugMessageInsert;
// 		private void* glDebugMessageCallback;
// 		private void* glGetDebugMessageLog;
// 		private void* glPushDebugGroup;
// 		private void* glPopDebugGroup;
// 		private void* glObjectLabel;
// 		private void* glGetObjectLabel;
// 		private void* glObjectPtrLabel;
// 		private void* glGetObjectPtrLabel;
// 		private void* glEnablei;
// 		private void* glDisablei;
// 		private void* glBlendEquationi;
// 		private void* glBlendEquationSeparatei;
// 		private void* glBlendFunci;
// 		private void* glBlendFuncSeparatei;
// 		private void* glColorMaski;
// 		private void* glIsEnabledi;
// 		private void* glDrawElementsBaseVertex;
// 		private void* glDrawRangeElementsBaseVertex;
// 		private void* glDrawElementsInstancedBaseVertex;
// 		private void* glFramebufferTexture;
// 		private void* glPrimitiveBoundingBox;
// 		private void* glGetGraphicsResetStatus;
// 		private void* glReadnPixels;
// 		private void* glGetnUniformfv;
// 		private void* glGetnUniformiv;
// 		private void* glGetnUniformuiv;
// 		private void* glMinSampleShading;
// 		private void* glPatchParameteri;
// 		private void* glTexParameterIiv;
// 		private void* glTexParameterIuiv;
// 		private void* glGetTexParameterIiv;
// 		private void* glGetTexParameterIuiv;
// 		private void* glSamplerParameterIiv;
// 		private void* glSamplerParameterIuiv;
// 		private void* glGetSamplerParameterIiv;
// 		private void* glGetSamplerParameterIuiv;
// 		private void* glTexBuffer;
// 		private void* glTexBufferRange;
// 		private void* glTexStorage3DMultisample;
// #pragma warning restore 0169
// 	}
// #endif
// }
}