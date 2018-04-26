//
//  UIDevice+Extension.m
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIDevice+Extension.h"
#import "NSString+YYAdd.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#include <sys/utsname.h>
#include <sys/socket.h> // Per msqr
#include <sys/sockio.h>
#include <sys/ioctl.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <arpa/inet.h>
#include <ifaddrs.h>
#include <mach/mach.h>

#define IOS_CELLULAR @"pdp_ip0"
#define IOS_WIFI @"en0"
#define IOS_VPN @"utun0"
#define IP_ADDR_IPv4 @"ipv4"
#define IP_ADDR_IPv6 @"ipv6"

@implementation UIDevice (Extension)

+ (NSString *)generateUuidString {
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    // release the UUID
    CFRelease(uuid);
    
    return uuidString;
}

+ (NSString *)deviceModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+ (NSString *)systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)device_brand {
    return [UIDevice currentDevice].model;
}

+ (NSString *)appleIFV {
    NSString *appleIdfv = [UIDevice currentDevice].identifierForVendor.UUIDString;
    return appleIdfv.md5String;
}

+ (NSString *)getVersionNumber {
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

+ (NSString *)platform {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithUTF8String:machine];
    free(machine);
    return platform;
}

+ (BOOL)isIphoneX {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]) {
        // judgment by height when in simulators
        return (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 812)) ||
                CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(812, 375)));
    }
    BOOL isIPhoneX = [platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"];
    return isIPhoneX;
}

+ (BOOL)isSimulator {
    return [[self platformString] isEqualToString:@"Simulator"];
}

+ (NSString *)platformString {
    NSString *platform = [self platform];
    if ([platform isEqualToString:@"iPhone1,1"])
        return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])
        return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])
        return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])
        return @"iPhone 4 (GSM)";
    if ([platform isEqualToString:@"iPhone3,3"])
        return @"iPhone 4 (CDMA)";
    if ([platform isEqualToString:@"iPhone4,1"])
        return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])
        return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])
        return @"iPhone 5 (CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])
        return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone5,4"])
        return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"])
        return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone6,2"])
        return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,1"])
        return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])
        return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])
        return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"])
        return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPod1,1"])
        return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])
        return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])
        return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])
        return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])
        return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])
        return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])
        return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])
        return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])
        return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])
        return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])
        return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])
        return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])
        return @"iPad Mini (CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])
        return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])
        return @"iPad 3 (CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])
        return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])
        return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])
        return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])
        return @"iPad 4 (CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])
        return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])
        return @"iPad Air (GSM)";
    if ([platform isEqualToString:@"iPad4,3"])
        return @"iPad Air (CDMA)";
    if ([platform isEqualToString:@"iPad4,4"])
        return @"iPad Mini Retina (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])
        return @"iPad Mini Retina (Cellular)";
    if ([platform isEqualToString:@"iPad4,7"])
        return @"iPad Mini 3 (WiFi)";
    if ([platform isEqualToString:@"iPad4,8"])
        return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad4,9"])
        return @"iPad Mini 3 (Cellular)";
    if ([platform isEqualToString:@"iPad5,1"])
        return @"iPad Mini 4 (WiFi)";
    if ([platform isEqualToString:@"iPad5,2"])
        return @"iPad Mini 4 (Cellular)";
    if ([platform isEqualToString:@"iPad5,3"])
        return @"iPad Air 2 (WiFi)";
    if ([platform isEqualToString:@"iPad5,4"])
        return @"iPad Air 2 (Cellular)";
    
    if ([platform isEqualToString:@"i386"])
        return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])
        return @"Simulator";
    
    return platform;
}

+ (BOOL)screenMatchesSize:(CGSize)size {
    return CGSizeEqualToSize(size, [[UIScreen mainScreen] currentMode].size);
}

+ (BOOL)p35InchDisplay {
    return [self screenMatchesSize:CGSizeMake(640, 960)] || [self screenMatchesSize:CGSizeMake(960, 640)];
}

+ (BOOL)p4InchDisplay {
    return [self screenMatchesSize:CGSizeMake(640, 1136)] || [self screenMatchesSize:CGSizeMake(1136, 640)];
}

+ (BOOL)p47InchDisplay {
    return [self screenMatchesSize:CGSizeMake(750, 1334)] || [self screenMatchesSize:CGSizeMake(1334, 750)];
}

+ (BOOL)p55InchDiplay {
    return [self screenMatchesSize:CGSizeMake(1242, 2208)] || [self screenMatchesSize:CGSizeMake(1334, 750)] ||
    [self screenMatchesSize:CGSizeMake(1125, 2001)] || [self screenMatchesSize:CGSizeMake(2001, 1125)];
}

+ (NSString *)getIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    //  NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if ([self isValidatIP:address])
            *stop = YES;
    }];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch =
        [regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if (!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for (interface = interfaces; interface; interface = interface->ifa_next) {
            if (!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in *)interface->ifa_addr;
            char addrBuf[MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN)];
            if (addr && (addr->sin_family == AF_INET || addr->sin_family == AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if (addr->sin_family == AF_INET) {
                    if (inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6 *)interface->ifa_addr;
                    if (inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if (type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSString *)getCarrierName {
    
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    return [NSString stringWithFormat:@"%@", [carrier carrierName]];
}

+ (NSUInteger)getCurrentDeviceCPUCount {
    return [NSProcessInfo processInfo].activeProcessorCount;
}

+ (CGFloat)getCurrentDeviceAllCoreCPUUse {
    
    CGFloat cpu = 0;
    
    NSArray *cpus = [self getCurrentDeviceSingleCoreCPUUse];
    
    if (cpus.count == 0) return -1;
    
    for (NSNumber *n in cpus) {
        cpu += n.floatValue;
    }
    return cpu;
}

+ (NSArray *)getCurrentDeviceSingleCoreCPUUse {
    
    processor_info_array_t _cpuInfo, _prevCPUInfo = nil;
    mach_msg_type_number_t _numCPUInfo, _numPrevCPUInfo = 0;
    
    unsigned _numCPUs;
    NSLock *_cpuUsageLock;
    
    int _mib[2U] = {CTL_HW, HW_NCPU};
    
    size_t _sizeOfNumCPUs = sizeof(_numCPUs);
    
    int _status = sysctl(_mib, 2U, &_numCPUs, &_sizeOfNumCPUs, NULL, 0U);
    
    if (_status) {
        _numCPUs = 1;
    }
    
    _cpuUsageLock = [[NSLock alloc] init];
    
    natural_t _numCPUsU = 0U;
    
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &_numCPUsU, &_cpuInfo, &_numCPUInfo);
    
    if (err == KERN_SUCCESS) {
        [_cpuUsageLock lock];
        
        NSMutableArray *cpus = [NSMutableArray new];
        for (unsigned i = 0U; i < _numCPUs; ++i) {
            Float32 _inUse, _total;
            if (_prevCPUInfo) {
                _inUse = ((_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                          + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]));
                _total = _inUse + (_cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - _prevCPUInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                _inUse = _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                _total = _inUse + _cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            [cpus addObject:@(_inUse / _total)];
        }
        [_cpuUsageLock unlock];
        if (_prevCPUInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * _numPrevCPUInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)_prevCPUInfo, prevCpuInfoSize);
        }
        return cpus;
    } else {
        return nil;
    }
}

+ (NSString *)getCurrentDeviceIPAddressWithWiFi {
    return [self getCurrentDeviceIPAddressWithName:@"en0"];
}

+ (NSString *)getCurrentDeviceIPAddressWithCell {
    return [self getCurrentDeviceIPAddressWithName:@"pdp_ip0"];
}

+ (NSString *)getCurrentDeviceIPAddressWithName:(NSString *)name {
    
    if (name.length == 0) return nil;
    
    NSString *address = nil;
    
    struct ifaddrs *addrs = NULL;
    
    if (getifaddrs(&addrs) == 0) {
        
        struct ifaddrs *addr = addrs;
        
        while (addr) {
            
            if ([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:name]) {
                
                sa_family_t family = addr->ifa_addr->sa_family;
                
                switch (family) {
                        
                    case AF_INET: { // IPv4
                        
                        char str[INET_ADDRSTRLEN] = {0};
                        
                        inet_ntop(family, &(((struct sockaddr_in *)addr->ifa_addr)->sin_addr), str, sizeof(str));
                        
                        if (strlen(str) > 0) {
                            
                            address = [NSString stringWithUTF8String:str];
                        }
                        
                    } break;
                        
                    case AF_INET6: { // IPv6
                        
                        char str[INET6_ADDRSTRLEN] = {0};
                        
                        inet_ntop(family, &(((struct sockaddr_in6 *)addr->ifa_addr)->sin6_addr), str, sizeof(str));
                        
                        if (strlen(str) > 0) {
                            
                            address = [NSString stringWithUTF8String:str];
                        }
                    }
                        
                    default: break;
                }
                
                if (address) break;
            }
            
            addr = addr->ifa_next;
        }
    }
    
    freeifaddrs(addrs);
    
    return address ? address : @"该设备不存在该ip地址";
}

+ (NSString *)getCurrentDeviceIPAddresses {
    
    int sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    
    NSMutableArray *ips = [NSMutableArray array];
    
    int BUFFERSIZE = 4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len = BUFFERSIZE;
    ifc.ifc_buf = buffer;
    
    if (ioctl(sockfd, SIOCGIFCONF, &ifc) >= 0){
        
        for (ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq *)ptr;
            
            int len = sizeof(struct sockaddr);
            
            if (ifr->ifr_addr.sa_len > len) {
                
                len = ifr->ifr_addr.sa_len;
            }
            
            ptr += sizeof(ifr->ifr_name) + len;
            
            if (ifr->ifr_addr.sa_family != AF_INET) continue;
            
            if ((cptr = (char *)strchr(ifr->ifr_name, ':')) != NULL) *cptr = 0;
            
            if (strncmp(lastname, ifr->ifr_name, IFNAMSIZ) == 0) continue;
            
            memcpy(lastname, ifr->ifr_name, IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd, SIOCGIFFLAGS, &ifrcopy);
            
            if ((ifrcopy.ifr_flags & IFF_UP) == 0) continue;
            
            NSString *ip = [NSString  stringWithFormat:@"%s", inet_ntoa(((struct sockaddr_in *)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
        }
    }
    
    close(sockfd);
    
    NSString *deviceIP = @"";
    
    for (NSInteger i = 0; i < ips.count; i++) {
        
        if (ips.count > 0) {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
        }
    }
    
    return deviceIP;
}
@end
