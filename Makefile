#
# OMNeT++/OMNEST Makefile for oppline
#
# This file was generated with the command:
#  opp_makemake -f --deep -O out -I../inet/src -L../inet/out/$$\(CONFIGNAME\)/src -lINET -KINET_PROJ=../inet
#

# Name of target to be created (-o option)
TARGET = oppline$(EXE_SUFFIX)

# User interface (uncomment one) (-u option)
USERIF_LIBS = $(ALL_ENV_LIBS) # that is, $(TKENV_LIBS) $(QTENV_LIBS) $(CMDENV_LIBS)
#USERIF_LIBS = $(CMDENV_LIBS)
#USERIF_LIBS = $(TKENV_LIBS)
#USERIF_LIBS = $(QTENV_LIBS)

# C++ include paths (with -I)
INCLUDE_PATH = \
    -I../inet/src \
    -I. \
    -Ipython \
    -Iresults \
    -Iresults/223mx223m_10_540 \
    -Iresults/223mx223m_10_60 \
    -Iresults/223mx223m_10_900 \
    -Iresults/223mx223m_20_540 \
    -Iresults/223mx223m_20_60 \
    -Iresults/223mx223m_20_900 \
    -Iresults/223mx223m_40_60 \
    -Iresults/335mx335m_10_540 \
    -Iresults/335mx335m_10_60 \
    -Iresults/335mx335m_10_900 \
    -Iresults/335mx335m_20_540 \
    -Iresults/335mx335m_20_60 \
    -Iresults/335mx335m_20_900 \
    -Iresults/old \
    -Iresults/old/100tests \
    -Iresults/old/223mx223m_10_900_old \
    -Iresults/test_fix_223mx223m_10_540 \
    -Iresults/test_fix_223mx223m_10_60 \
    -Iresults/test_fix_223mx223m_10_900 \
    -Iresults/transient \
    -Iresults/transient/223mx223m_10_540 \
    -Iresults/transient/223mx223m_10_60 \
    -Iresults/transient/223mx223m_10_90 \
    -Iresults/transient/223mx223m_10_900 \
    -Iresults/transient/335mx335m_10_60

# Additional object and library files to link with
EXTRA_OBJS =

# Additional libraries (-L, -l options)
LIBS = -L../inet/out/$(CONFIGNAME)/src  -lINET
LIBS += -Wl,-rpath,`abspath ../inet/out/$(CONFIGNAME)/src`

# Output directory
PROJECT_OUTPUT_DIR = out
PROJECTRELATIVE_PATH =
O = $(PROJECT_OUTPUT_DIR)/$(CONFIGNAME)/$(PROJECTRELATIVE_PATH)

# Object files for local .cc, .msg and .sm files
OBJS = $O/CircularQueue.o $O/OpplineApp.o $O/SSIDMessage.o

# Message files
MSGFILES =

# SM files
SMFILES =

# Other makefile variables (-K)
INET_PROJ=../inet

#------------------------------------------------------------------------------

# Pull in OMNeT++ configuration (Makefile.inc or configuser.vc)

ifneq ("$(OMNETPP_CONFIGFILE)","")
CONFIGFILE = $(OMNETPP_CONFIGFILE)
else
ifneq ("$(OMNETPP_ROOT)","")
CONFIGFILE = $(OMNETPP_ROOT)/Makefile.inc
else
CONFIGFILE = $(shell opp_configfilepath)
endif
endif

ifeq ("$(wildcard $(CONFIGFILE))","")
$(error Config file '$(CONFIGFILE)' does not exist -- add the OMNeT++ bin directory to the path so that opp_configfilepath can be found, or set the OMNETPP_CONFIGFILE variable to point to Makefile.inc)
endif

include $(CONFIGFILE)

# Simulation kernel and user interface libraries
OMNETPP_LIB_SUBDIR = $(OMNETPP_LIB_DIR)/$(TOOLCHAIN_NAME)
OMNETPP_LIBS = -L"$(OMNETPP_LIB_SUBDIR)" -L"$(OMNETPP_LIB_DIR)" -loppmain$D $(USERIF_LIBS) $(KERNEL_LIBS) $(SYS_LIBS)

COPTS = $(CFLAGS)  $(INCLUDE_PATH) -I$(OMNETPP_INCL_DIR)
MSGCOPTS = $(INCLUDE_PATH)
SMCOPTS =

# we want to recompile everything if COPTS changes,
# so we store COPTS into $COPTS_FILE and have object
# files depend on it (except when "make depend" was called)
COPTS_FILE = $O/.last-copts
ifneq ($(MAKECMDGOALS),depend)
ifneq ("$(COPTS)","$(shell cat $(COPTS_FILE) 2>/dev/null || echo '')")
$(shell $(MKPATH) "$O" && echo "$(COPTS)" >$(COPTS_FILE))
endif
endif

#------------------------------------------------------------------------------
# User-supplied makefile fragment(s)
# >>>
# <<<
#------------------------------------------------------------------------------

# Main target
all: $O/$(TARGET)
	$(Q)$(LN) $O/$(TARGET) .

$O/$(TARGET): $(OBJS)  $(wildcard $(EXTRA_OBJS)) Makefile
	@$(MKPATH) $O
	@echo Creating executable: $@
	$(Q)$(CXX) $(LDFLAGS) -o $O/$(TARGET)  $(OBJS) $(EXTRA_OBJS) $(AS_NEEDED_OFF) $(WHOLE_ARCHIVE_ON) $(LIBS) $(WHOLE_ARCHIVE_OFF) $(OMNETPP_LIBS)

.PHONY: all clean cleanall depend msgheaders smheaders

.SUFFIXES: .cc

$O/%.o: %.cc $(COPTS_FILE)
	@$(MKPATH) $(dir $@)
	$(qecho) "$<"
	$(Q)$(CXX) -c $(CXXFLAGS) $(COPTS) -o $@ $<

%_m.cc %_m.h: %.msg
	$(qecho) MSGC: $<
	$(Q)$(MSGC) -s _m.cc $(MSGCOPTS) $?

%_sm.cc %_sm.h: %.sm
	$(qecho) SMC: $<
	$(Q)$(SMC) -c++ -suffix cc $(SMCOPTS) $?

msgheaders: $(MSGFILES:.msg=_m.h)

smheaders: $(SMFILES:.sm=_sm.h)

clean:
	$(qecho) Cleaning...
	$(Q)-rm -rf $O
	$(Q)-rm -f oppline oppline.exe liboppline.so liboppline.a liboppline.dll liboppline.dylib
	$(Q)-rm -f ./*_m.cc ./*_m.h ./*_sm.cc ./*_sm.h
	$(Q)-rm -f python/*_m.cc python/*_m.h python/*_sm.cc python/*_sm.h
	$(Q)-rm -f results/*_m.cc results/*_m.h results/*_sm.cc results/*_sm.h
	$(Q)-rm -f results/223mx223m_10_540/*_m.cc results/223mx223m_10_540/*_m.h results/223mx223m_10_540/*_sm.cc results/223mx223m_10_540/*_sm.h
	$(Q)-rm -f results/223mx223m_10_60/*_m.cc results/223mx223m_10_60/*_m.h results/223mx223m_10_60/*_sm.cc results/223mx223m_10_60/*_sm.h
	$(Q)-rm -f results/223mx223m_10_900/*_m.cc results/223mx223m_10_900/*_m.h results/223mx223m_10_900/*_sm.cc results/223mx223m_10_900/*_sm.h
	$(Q)-rm -f results/223mx223m_20_540/*_m.cc results/223mx223m_20_540/*_m.h results/223mx223m_20_540/*_sm.cc results/223mx223m_20_540/*_sm.h
	$(Q)-rm -f results/223mx223m_20_60/*_m.cc results/223mx223m_20_60/*_m.h results/223mx223m_20_60/*_sm.cc results/223mx223m_20_60/*_sm.h
	$(Q)-rm -f results/223mx223m_20_900/*_m.cc results/223mx223m_20_900/*_m.h results/223mx223m_20_900/*_sm.cc results/223mx223m_20_900/*_sm.h
	$(Q)-rm -f results/223mx223m_40_60/*_m.cc results/223mx223m_40_60/*_m.h results/223mx223m_40_60/*_sm.cc results/223mx223m_40_60/*_sm.h
	$(Q)-rm -f results/335mx335m_10_540/*_m.cc results/335mx335m_10_540/*_m.h results/335mx335m_10_540/*_sm.cc results/335mx335m_10_540/*_sm.h
	$(Q)-rm -f results/335mx335m_10_60/*_m.cc results/335mx335m_10_60/*_m.h results/335mx335m_10_60/*_sm.cc results/335mx335m_10_60/*_sm.h
	$(Q)-rm -f results/335mx335m_10_900/*_m.cc results/335mx335m_10_900/*_m.h results/335mx335m_10_900/*_sm.cc results/335mx335m_10_900/*_sm.h
	$(Q)-rm -f results/335mx335m_20_540/*_m.cc results/335mx335m_20_540/*_m.h results/335mx335m_20_540/*_sm.cc results/335mx335m_20_540/*_sm.h
	$(Q)-rm -f results/335mx335m_20_60/*_m.cc results/335mx335m_20_60/*_m.h results/335mx335m_20_60/*_sm.cc results/335mx335m_20_60/*_sm.h
	$(Q)-rm -f results/335mx335m_20_900/*_m.cc results/335mx335m_20_900/*_m.h results/335mx335m_20_900/*_sm.cc results/335mx335m_20_900/*_sm.h
	$(Q)-rm -f results/old/*_m.cc results/old/*_m.h results/old/*_sm.cc results/old/*_sm.h
	$(Q)-rm -f results/old/100tests/*_m.cc results/old/100tests/*_m.h results/old/100tests/*_sm.cc results/old/100tests/*_sm.h
	$(Q)-rm -f results/old/223mx223m_10_900_old/*_m.cc results/old/223mx223m_10_900_old/*_m.h results/old/223mx223m_10_900_old/*_sm.cc results/old/223mx223m_10_900_old/*_sm.h
	$(Q)-rm -f results/test_fix_223mx223m_10_540/*_m.cc results/test_fix_223mx223m_10_540/*_m.h results/test_fix_223mx223m_10_540/*_sm.cc results/test_fix_223mx223m_10_540/*_sm.h
	$(Q)-rm -f results/test_fix_223mx223m_10_60/*_m.cc results/test_fix_223mx223m_10_60/*_m.h results/test_fix_223mx223m_10_60/*_sm.cc results/test_fix_223mx223m_10_60/*_sm.h
	$(Q)-rm -f results/test_fix_223mx223m_10_900/*_m.cc results/test_fix_223mx223m_10_900/*_m.h results/test_fix_223mx223m_10_900/*_sm.cc results/test_fix_223mx223m_10_900/*_sm.h
	$(Q)-rm -f results/transient/*_m.cc results/transient/*_m.h results/transient/*_sm.cc results/transient/*_sm.h
	$(Q)-rm -f results/transient/223mx223m_10_540/*_m.cc results/transient/223mx223m_10_540/*_m.h results/transient/223mx223m_10_540/*_sm.cc results/transient/223mx223m_10_540/*_sm.h
	$(Q)-rm -f results/transient/223mx223m_10_60/*_m.cc results/transient/223mx223m_10_60/*_m.h results/transient/223mx223m_10_60/*_sm.cc results/transient/223mx223m_10_60/*_sm.h
	$(Q)-rm -f results/transient/223mx223m_10_90/*_m.cc results/transient/223mx223m_10_90/*_m.h results/transient/223mx223m_10_90/*_sm.cc results/transient/223mx223m_10_90/*_sm.h
	$(Q)-rm -f results/transient/223mx223m_10_900/*_m.cc results/transient/223mx223m_10_900/*_m.h results/transient/223mx223m_10_900/*_sm.cc results/transient/223mx223m_10_900/*_sm.h
	$(Q)-rm -f results/transient/335mx335m_10_60/*_m.cc results/transient/335mx335m_10_60/*_m.h results/transient/335mx335m_10_60/*_sm.cc results/transient/335mx335m_10_60/*_sm.h

cleanall: clean
	$(Q)-rm -rf $(PROJECT_OUTPUT_DIR)

depend:
	$(qecho) Creating dependencies...
	$(Q)$(MAKEDEPEND) $(INCLUDE_PATH) -f Makefile -P\$$O/ -- $(MSG_CC_FILES) $(SM_CC_FILES)  ./*.cc python/*.cc results/*.cc results/223mx223m_10_540/*.cc results/223mx223m_10_60/*.cc results/223mx223m_10_900/*.cc results/223mx223m_20_540/*.cc results/223mx223m_20_60/*.cc results/223mx223m_20_900/*.cc results/223mx223m_40_60/*.cc results/335mx335m_10_540/*.cc results/335mx335m_10_60/*.cc results/335mx335m_10_900/*.cc results/335mx335m_20_540/*.cc results/335mx335m_20_60/*.cc results/335mx335m_20_900/*.cc results/old/*.cc results/old/100tests/*.cc results/old/223mx223m_10_900_old/*.cc results/test_fix_223mx223m_10_540/*.cc results/test_fix_223mx223m_10_60/*.cc results/test_fix_223mx223m_10_900/*.cc results/transient/*.cc results/transient/223mx223m_10_540/*.cc results/transient/223mx223m_10_60/*.cc results/transient/223mx223m_10_90/*.cc results/transient/223mx223m_10_900/*.cc results/transient/335mx335m_10_60/*.cc

# DO NOT DELETE THIS LINE -- make depend depends on it.
$O/CircularQueue.o: CircularQueue.cc \
	$(INET_PROJ)/src/inet/common/Compat.h \
	$(INET_PROJ)/src/inet/common/INETDefs.h \
	$(INET_PROJ)/src/inet/common/InitStages.h \
	$(INET_PROJ)/src/inet/features.h \
	$(INET_PROJ)/src/inet/linklayer/common/MACAddress.h \
	CircularQueue.h \
	SSIDMessage.h
$O/OpplineApp.o: OpplineApp.cc \
	$(INET_PROJ)/src/inet/common/Compat.h \
	$(INET_PROJ)/src/inet/common/DelayedInitializer.h \
	$(INET_PROJ)/src/inet/common/INETDefs.h \
	$(INET_PROJ)/src/inet/common/INETMath.h \
	$(INET_PROJ)/src/inet/common/InitStages.h \
	$(INET_PROJ)/src/inet/common/LayeredProtocolBase.h \
	$(INET_PROJ)/src/inet/common/NotifierConsts.h \
	$(INET_PROJ)/src/inet/common/Units.h \
	$(INET_PROJ)/src/inet/common/geometry/common/Coord.h \
	$(INET_PROJ)/src/inet/common/geometry/common/EulerAngles.h \
	$(INET_PROJ)/src/inet/common/lifecycle/ILifecycle.h \
	$(INET_PROJ)/src/inet/common/lifecycle/LifecycleOperation.h \
	$(INET_PROJ)/src/inet/common/lifecycle/NodeOperations.h \
	$(INET_PROJ)/src/inet/common/lifecycle/OperationalBase.h \
	$(INET_PROJ)/src/inet/common/mapping/Interpolation.h \
	$(INET_PROJ)/src/inet/common/mapping/MappingBase.h \
	$(INET_PROJ)/src/inet/common/mapping/MappingUtils.h \
	$(INET_PROJ)/src/inet/features.h \
	$(INET_PROJ)/src/inet/linklayer/base/MACProtocolBase.h \
	$(INET_PROJ)/src/inet/linklayer/common/Ieee802Ctrl_m.h \
	$(INET_PROJ)/src/inet/linklayer/common/MACAddress.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mac/IMacRadioInterface.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mac/Ieee80211Frame_m.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mac/Ieee80211Mac.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211AgentSTA.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211MgmtAP.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211MgmtAPBase.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211MgmtBase.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211MgmtFrames_m.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211MgmtSTA.h \
	$(INET_PROJ)/src/inet/linklayer/ieee80211/mgmt/Ieee80211Primitives_m.h \
	$(INET_PROJ)/src/inet/mobility/contract/IMobility.h \
	$(INET_PROJ)/src/inet/networklayer/common/InterfaceEntry.h \
	$(INET_PROJ)/src/inet/networklayer/common/InterfaceTable.h \
	$(INET_PROJ)/src/inet/networklayer/common/InterfaceToken.h \
	$(INET_PROJ)/src/inet/networklayer/common/L3Address.h \
	$(INET_PROJ)/src/inet/networklayer/common/ModuleIdAddress.h \
	$(INET_PROJ)/src/inet/networklayer/common/ModulePathAddress.h \
	$(INET_PROJ)/src/inet/networklayer/contract/IInterfaceTable.h \
	$(INET_PROJ)/src/inet/networklayer/contract/ipv4/IPv4Address.h \
	$(INET_PROJ)/src/inet/networklayer/contract/ipv6/IPv6Address.h \
	$(INET_PROJ)/src/inet/physicallayer/base/packetlevel/PhysicalLayerDefs.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/bitlevel/ISignalAnalogModel.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IAntenna.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IArrival.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IInterference.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IListening.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IListeningDecision.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IModulation.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/INoise.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IPhysicalLayer.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IPhysicalLayerFrame.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IPrintableObject.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IRadio.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IRadioFrame.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IRadioSignal.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IReceiver.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IReception.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IReceptionDecision.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/IReceptionResult.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/ISNIR.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/ITransmission.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/ITransmitter.h \
	$(INET_PROJ)/src/inet/physicallayer/contract/packetlevel/RadioControlInfo_m.h \
	$(INET_PROJ)/src/inet/physicallayer/ieee80211/mode/IIeee80211Mode.h \
	$(INET_PROJ)/src/inet/physicallayer/ieee80211/mode/Ieee80211ModeSet.h \
	CircularQueue.h \
	SSIDMessage.h
$O/SSIDMessage.o: SSIDMessage.cc \
	$(INET_PROJ)/src/inet/common/Compat.h \
	$(INET_PROJ)/src/inet/common/INETDefs.h \
	$(INET_PROJ)/src/inet/common/InitStages.h \
	$(INET_PROJ)/src/inet/features.h \
	$(INET_PROJ)/src/inet/linklayer/common/MACAddress.h \
	SSIDMessage.h

